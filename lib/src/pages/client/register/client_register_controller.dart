import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:uber_clone/src/models/client.dart';
import 'package:uber_clone/src/providers/auth_provider.dart';
import 'package:uber_clone/src/providers/client_provider.dart';
import 'package:uber_clone/src/utils/progress_dialog.dart';
import 'package:uber_clone/src/utils/snackbar.dart' as utils;

class ClientRegisterController {
  late BuildContext context;
  late GlobalKey<ScaffoldMessengerState> key =
      GlobalKey<ScaffoldMessengerState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  late AuthProvider _authProvider;
  late ClientProvider _clientProvider;
  late ProgressDialog _progressDialog;

  Future<void> init(BuildContext context) async {
    this.context = context;
    print('init client');
    _authProvider = AuthProvider();
    _clientProvider = ClientProvider();
    _progressDialog =
        ProgressDialogCustom.createProgressDialog(context, 'Wait a moment...');
  }

  void register() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String username = usernameController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (username.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      print('All field are required!');
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
        Client client = Client(
            id: _authProvider.getUser()!.uid,
            email: _authProvider.getUser()!.email ?? email,
            username: username,
            password: password);

        await _clientProvider.create(client);
        _progressDialog.hide();
        Navigator.pushNamedAndRemoveUntil(
            context, 'client/map', (route) => false);
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
