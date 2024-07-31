import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:uber_clone/src/utils/colors.dart' as utils;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            _bannerApp(),
            _textDescription(),
            _textLogin(),
            const SizedBox(
              height: 40,
            ),
            Expanded(
              child: Container(),
            ),
            // _textFieldEmail(),
            // _textFieldPassword(),
            // _buttonLogin(),
            // _textDontHaveAccount()
          ],
        ));
  }

  //
  // Widget _textDontHaveAccount() {
  //   return Container(
  //     margin: const EdgeInsets.only(bottom: 50),
  //     child: const Text(
  //       'Dont have an account?',
  //       style: TextStyle(fontSize: 15, color: Colors.grey),
  //     ),
  //   );
  // }
  //
  // Widget _buttonLogin() {
  //   return const ButtonApp(
  //     text: 'Login',
  //     color: utils.Colors.uberColor,
  //   );
  // }

  Widget _textFieldPassword() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: const TextField(
          obscureText: true,
          decoration: InputDecoration(
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
      child: const TextField(
          decoration: InputDecoration(
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
      child: const Text(
        'Login',
        style: TextStyle(
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
