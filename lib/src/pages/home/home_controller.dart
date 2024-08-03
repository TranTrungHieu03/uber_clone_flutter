import 'package:flutter/material.dart';
import 'package:uber_clone/src/providers/auth_provider.dart';
import 'package:uber_clone/src/utils/shared_pref.dart';

class HomeController {
  late BuildContext context;
  late SharedPref _sharedPref;
  late AuthProvider _authProvider;
  late String _typeUser;

  Future<void> init(BuildContext context) async {
    this.context = context;
    _sharedPref = SharedPref();
    _authProvider = AuthProvider();
    _typeUser = await _sharedPref.read('typeUser') ?? '';
    print('PREVIOUS TYPE: $_typeUser');
    // _authProvider.checkIfUserIsLogged(context, _typeUser);
    checkIfUserIsAuth();
  }

  void checkIfUserIsAuth() {
    bool isSigned = _authProvider.isSignedIn();
    if (isSigned) {
      if (_typeUser == 'client') {
        Navigator.pushNamedAndRemoveUntil(
            context, 'client/map', (route) => false);
      } else if (_typeUser == 'driver') {
        Navigator.pushNamedAndRemoveUntil(
            context, 'driver/map', (route) => false);
      }
    } else {
      print('No signed user');
    }
  }

  void goToLoginPage(String typeUser) {
    saveTypeUser(typeUser);
    print('TYPE INIT: $typeUser');
    Navigator.pushNamed(context, 'login');
  }

  Future<void> saveTypeUser(String typeUser) async {
    await _sharedPref.save('typeUser', typeUser);
  }

  Future<void> clearTypeUser() async {
    await _sharedPref.remove('typeUser');
  }
}
