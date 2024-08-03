import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_clone/src/models/client.dart';

class ClientProvider {
  late CollectionReference _ref;

  ClientProvider() {
    _ref = FirebaseFirestore.instance.collection('Clients');
  }

  Future<void> create(Client client) async {
    String? errorMessage;
    try {
      return _ref.doc(client.id).set(client.toJson());
    } on FirebaseException catch (e) {
      errorMessage = e.code;
    }
    return Future.error(errorMessage);
  }

  Future<Client> getById(String id) async {
    DocumentSnapshot document = await _ref.doc(id).get();
    Client client = Client.fromJson(document.data() as Map<String, dynamic>);
    return client;
  }
}
