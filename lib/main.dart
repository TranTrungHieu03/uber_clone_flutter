import 'package:flutter/material.dart';
import 'package:uber_clone/src/pages/home/home_page.dart';
import 'package:uber_clone/src/pages/login/login_page.dart';
import 'package:uber_clone/src/utils/colors.dart' as utils;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyState();
}

class _MyState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flor',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomePage(),
        'login': (BuildContext context) => const LoginPage(),
      },
      theme: ThemeData(
          fontFamily: 'KumbhSans',
          appBarTheme: const AppBarTheme(elevation: 0),
          primaryColor: utils.Colors.uberColor),
      debugShowCheckedModeBanner: false,
    );
  }
}
