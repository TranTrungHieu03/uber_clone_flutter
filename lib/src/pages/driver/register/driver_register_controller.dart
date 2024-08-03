import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:uber_clone/src/models/driver.dart';
import 'package:uber_clone/src/providers/auth_provider.dart';
import 'package:uber_clone/src/providers/driver_provider.dart';
import 'package:uber_clone/src/utils/progress_dialog.dart';
import 'package:uber_clone/src/utils/snackbar.dart' as utils;

class DriverRegisterController {
  late BuildContext context;
  late GlobalKey<ScaffoldMessengerState> key =
      GlobalKey<ScaffoldMessengerState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController pin1Controller = TextEditingController();
  TextEditingController pin2Controller = TextEditingController();
  TextEditingController pin3Controller = TextEditingController();
  TextEditingController pin4Controller = TextEditingController();
  TextEditingController pin5Controller = TextEditingController();
  TextEditingController pin6Controller = TextEditingController();

  late AuthProvider _authProvider;
  late DriverProvider _driverProvider;
  late ProgressDialog _progressDialog;

  Future<void> init(BuildContext context) async {
    this.context = context;
    print('init client');
    _authProvider = AuthProvider();
    _driverProvider = DriverProvider();
    _progressDialog =
        ProgressDialogCustom.createProgressDialog(context, 'Wait a moment...');
  }

  void register() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String username = usernameController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();
    String pin1 = pin1Controller.text.trim();
    String pin2 = pin2Controller.text.trim();
    String pin3 = pin3Controller.text.trim();
    String pin4 = pin4Controller.text.trim();
    String pin5 = pin5Controller.text.trim();
    String pin6 = pin6Controller.text.trim();
    String plate = '$pin1$pin2$pin3-$pin4$pin5$pin6';

    if (username.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      print('All field are required!');
      print(key.currentState != null);
      utils.SnackBarCustom.showSnackBar(
          context, key, 'All field are required!');
      return;
    }
    if (confirmPassword != password) {
      print('Password is not matched');
      utils.SnackBarCustom.showSnackBar(
          context, key, 'Password is not matched');
      return;
    }
    if (password.length < 6) {
      print('Password must be at least 6 characters');
      utils.SnackBarCustom.showSnackBar(
          context, key, 'Password must be at least 6 characters');
      return;
    }
    _progressDialog.show();
    try {
      bool isRegister = await _authProvider.register(email, password);
      if (isRegister) {
        Driver driver = Driver(
            id: _authProvider.getUser()!.uid,
            email: _authProvider.getUser()!.email ?? email,
            username: username,
            password: password,
            plate: plate);

        await _driverProvider.create(driver);
        _progressDialog.hide();
        Navigator.pushNamedAndRemoveUntil(
            context, 'driver/map', (route) => false);
        print('Register successfully!');
        utils.SnackBarCustom.showSnackBar(
            context, key, 'Register successfully!');
      } else {
        _progressDialog.hide();
        print('Something wrong');
        utils.SnackBarCustom.showSnackBar(context, key, 'Something wrong');
      }
    } catch (e) {
      _progressDialog.hide();
      print('Error: $e');
    }
  }
}
