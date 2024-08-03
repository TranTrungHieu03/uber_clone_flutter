import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:uber_clone/src/models/client.dart';
import 'package:uber_clone/src/models/driver.dart';
import 'package:uber_clone/src/providers/auth_provider.dart';
import 'package:uber_clone/src/providers/client_provider.dart';
import 'package:uber_clone/src/providers/driver_provider.dart';
import 'package:uber_clone/src/utils/progress_dialog.dart';
import 'package:uber_clone/src/utils/shared_pref.dart';
import 'package:uber_clone/src/utils/snackbar.dart' as utils;

class LoginController {
  late BuildContext context;
  GlobalKey<ScaffoldMessengerState> key = GlobalKey<ScaffoldMessengerState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late AuthProvider _authProvider;
  late ProgressDialog _progressDialog;
  late DriverProvider _driverProvider;
  late ClientProvider _clientProvider;

  late SharedPref _sharedPref;
  late String _typeUser;

  Future<void> init(BuildContext context) async {
    this.context = context;
    _authProvider = AuthProvider();
    _clientProvider = ClientProvider();
    _driverProvider = DriverProvider();
    _progressDialog =
        ProgressDialogCustom.createProgressDialog(context, 'Wait a moment...');
    _sharedPref = SharedPref();
    _typeUser = await _sharedPref.read('typeUser') ?? '';
  }

  void gotoRegisterPage() {
    if (_typeUser == 'client') {
      Navigator.pushNamed(context, 'client/register');
    } else {
      Navigator.pushNamed(context, 'driver/register');
    }
  }

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    _progressDialog.show();

    print('Email: $email Password: $password');
    try {
      bool isLogin = await _authProvider.login(email, password);
      _progressDialog.hide();
      await Future.delayed(const Duration(milliseconds: 300));
      if (isLogin) {
        utils.SnackBarCustom.showSnackBar(context, key, 'Login successfully!');
        print('Login success');
        if (_typeUser == 'client') {
          Client client =
              await _clientProvider.getById(_authProvider.getUser()!.uid);
          print('CLIENT: $client');
          if (client != null) {
            Navigator.pushNamedAndRemoveUntil(
                context, 'client/map', (route) => false);
          } else {
            print('Login failed');
            utils.SnackBarCustom.showSnackBar(context, key, 'Login failed!');
            await _authProvider.signOut();
          }
        } else if (_typeUser == 'driver') {
          Driver driver =
              await _driverProvider.getById(_authProvider.getUser()!.uid);
          print('DRIVER: $driver');
          if (driver != null) {
            Navigator.pushNamedAndRemoveUntil(
                context, 'driver/map', (route) => false);
          } else {
            utils.SnackBarCustom.showSnackBar(context, key, 'Login failed!');
            await _authProvider.signOut();
          }
        }
      } else {
        utils.SnackBarCustom.showSnackBar(context, key, 'Login failed!');

        print('Some thing wrong');
      }
    } catch (e) {
      print('Error: $e');
      _progressDialog.hide();
      utils.SnackBarCustom.showSnackBar(context, key, '$e');
    }
  }
}
