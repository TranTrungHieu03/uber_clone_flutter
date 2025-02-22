import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:uber_clone/src/pages/login/login_controller.dart';
import 'package:uber_clone/src/utils/colors.dart' as utils;

import '../../widgets/button_app.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController _con = LoginController();

  @override
  void initState() {
    super.initState();

    print('INIT  STATE');
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _con.init(context);
      print('METHOD SCHEDULE');
    });
  }

  @override
  Widget build(BuildContext context) {
    print('METHOD BUILD');
    return ScaffoldMessenger(
      key: _con.key,
      child: Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                _bannerApp(),
                _textDescription(),
                _textLogin(),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.17,
                ),
                _textFieldEmail(),
                _textFieldPassword(),
                _buttonLogin(),
                _textDontHaveAccount()
              ],
            ),
          )),
    );
  }

  Widget _textDontHaveAccount() {
    return GestureDetector(
      onTap: _con.gotoRegisterPage,
      child: Container(
        margin: const EdgeInsets.only(bottom: 50, top: 20),
        child: const Text(
          'Dont have an account?',
          style: TextStyle(fontSize: 15, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buttonLogin() {
    return ButtonApp(
      text: 'Login',
      color: utils.Colors.uberColor,
      textColor: Colors.white,
      onPressed: _con.login,
    );
  }

  Widget _textFieldPassword() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: TextField(
          controller: _con.passwordController,
          obscureText: true,
          decoration: const InputDecoration(
              labelText: 'Password',
              suffixIcon: Icon(
                Icons.lock_open_outlined,
                color: utils.Colors.uberColor,
              ))),
    );
  }

  Widget _textFieldEmail() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: TextField(
          controller: _con.emailController,
          decoration: const InputDecoration(
              hintText: 'example@gmail.com',
              labelText: 'Email ',
              suffixIcon: Icon(
                Icons.email_outlined,
                color: utils.Colors.uberColor,
              ))),
    );
  }

  Widget _textDescription() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: const Text(
        'Login to access your account',
        style: TextStyle(
          color: Colors.black,
          fontSize: 22,
        ),
      ),
    );
  }

  Widget _textLogin() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      alignment: Alignment.centerLeft,
      child: Text(
        'Login'.toUpperCase(),
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
      ),
    );
  }

  Widget _bannerApp() {
    return ClipPath(
      clipper: WaveClipperTwo(),
      child: Container(
        color: utils.Colors.uberColor,
        height: MediaQuery.of(context).size.height * 0.22,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/img/icons8-truck-96(-xxhdpi).png',
              width: 150,
              height: 150,
            ),
            const Text(
              'FLOR',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  wordSpacing: 8,
                  fontWeight: FontWeight.w700),
            )
          ],
        ),
      ),
    );
  }
}
