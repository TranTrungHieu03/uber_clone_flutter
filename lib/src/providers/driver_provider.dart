import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_clone/src/models/driver.dart';

class DriverProvider {
  late CollectionReference _ref;

  DriverProvider() {
    _ref = FirebaseFirestore.instance.collection('Drivers');
  }

  Future<void> create(Driver driver) async {
    String? errorMessage;
    try {
      return _ref.doc(driver.id).set(driver.toJson());
    } on FirebaseException catch (e) {
      errorMessage = e.code;
    }
    return Future.error(errorMessage);
  }

  Future<Driver?> getById(String id) async {
    DocumentSnapshot document = await _ref.doc(id).get();
    if (document.data() != null) {
      Driver driver = Driver.fromJson(document.data() as Map<String, dynamic>);
      return driver;
    }
    return null;
  }
}
