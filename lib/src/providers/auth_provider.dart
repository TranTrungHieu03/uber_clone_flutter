import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider {
  late FirebaseAuth _firebaseAuth;

  AuthProvider() {
    _firebaseAuth = FirebaseAuth.instance;
  }

  User? getUser() {
    return _firebaseAuth.currentUser;
  }

  bool isSignedIn() {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) {
      return false;
    }
    return true;
  }

  void checkIfUserIsLogged(BuildContext context, String typeUser) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null && typeUser != null) {
        print('user logged');
        await Future.delayed(const Duration(milliseconds: 200));
        if (typeUser == 'client') {
          Navigator.pushNamedAndRemoveUntil(
              context, 'client/map', (route) => false);
        } else if (typeUser == 'driver') {
          print(typeUser);
          Navigator.pushNamedAndRemoveUntil(
              context, 'driver/map', (route) => false);
        }
      } else {
        print('login failed');
      }
    });
  }

  Future<bool> login(String email, String password) async {
    String? errorMessage;
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e);
      errorMessage = e.code;
    }
    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
    return true;
  }

  Future<bool> register(String email, String password) async {
    String? errorMessage;
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e);
      errorMessage = e.code;
    }
    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
    return true;
  }

  Future<List<void>> signOut() async {
    return Future.wait([_firebaseAuth.signOut()]);
  }
}
