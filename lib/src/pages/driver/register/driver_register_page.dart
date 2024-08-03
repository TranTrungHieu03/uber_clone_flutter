import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:uber_clone/src/pages/driver/register/driver_register_controller.dart';
import 'package:uber_clone/src/utils/colors.dart' as utils;
import 'package:uber_clone/src/utils/otp_widget.dart';

import '../../../widgets/button_app.dart';

class DriverRegisterPage extends StatefulWidget {
  const DriverRegisterPage({super.key});

  @override
  State<DriverRegisterPage> createState() => _DriverRegisterPageState();
}

class _DriverRegisterPageState extends State<DriverRegisterPage> {
  final DriverRegisterController _con = DriverRegisterController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print('INIT  STATE DRIVER');
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
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
                _textRegister(),
                _textLicensePlate(),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  child: OTPFields(
                    pin1: _con.pin1Controller,
                    pin2: _con.pin2Controller,
                    pin3: _con.pin3Controller,
                    pin4: _con.pin4Controller,
                    pin5: _con.pin5Controller,
                    pin6: _con.pin6Controller,
                  ),
                ),
                _textFieldUsername(),
                _textFieldEmail(),
                _textFieldPassword(),
                _textFieldConfirmPassword(),
                _buttonRegister(),
              ],
            ),
          )),
    );
  }

  Widget _textLicensePlate() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: const Text(
        'License plates',
        style: TextStyle(
          color: Colors.orange,
          fontSize: 17,
        ),
      ),
    );
  }

  Widget _buttonRegister() {
    return ButtonApp(
      text: 'Register',
      color: utils.Colors.uberColor,
      textColor: Colors.white,
      onPressed: _con.register,
    );
  }

  Widget _textFieldUsername() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: TextField(
          controller: _con.usernameController,
          decoration: const InputDecoration(
              hintText: 'Customer Name',
              labelText: 'Username ',
              suffixIcon: Icon(
                Icons.person_outlined,
                color: utils.Colors.uberColor,
              ))),
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

  Widget _textFieldConfirmPassword() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: TextField(
          controller: _con.confirmPasswordController,
          obscureText: true,
          decoration: const InputDecoration(
              labelText: 'Confirm Password',
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
        'Let’s get you all set up so you can access your personal account.',
        style: TextStyle(
          color: Colors.black,
          fontSize: 22,
        ),
      ),
    );
  }

  Widget _textRegister() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      alignment: Alignment.centerLeft,
      child: Text(
        'Register'.toUpperCase(),
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
