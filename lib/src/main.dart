import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uber_clone/src/pages/client/map/client_map_page.dart';
import 'package:uber_clone/src/pages/client/register/client_register_page.dart';
import 'package:uber_clone/src/pages/driver/map/driver_map_page.dart';
import 'package:uber_clone/src/pages/driver/register/driver_register_page.dart';
import 'package:uber_clone/src/pages/home/home_page.dart';
import 'package:uber_clone/src/pages/login/login_page.dart';
import 'package:uber_clone/src/utils/colors.dart' as utils;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
          apiKey: 'AIzaSyCtBXTo5u4Cy6Qph-L7I7xJvqYAZS_VMyo',
          appId: '1:766087457:android:57e22eff6082b80b8e2e60',
          messagingSenderId: '766087457',
          projectId: 'uber-clone-flutter-d3926',
          // storageBucket: 'uber-clone-flutter-d3926.appspot.com'
        ))
      : await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
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
        'client/register': (BuildContext context) => const ClientRegisterPage(),
        'driver/register': (BuildContext context) => const DriverRegisterPage(),
        'driver/map': (BuildContext context) => const DriverMapPage(),
        'client/map': (BuildContext context) => const ClientMapPage(),
      },
      theme: ThemeData(
          fontFamily: 'KumbhSans',
          appBarTheme: const AppBarTheme(elevation: 0),
          primaryColor: utils.Colors.uberColor),
      debugShowCheckedModeBanner: false,
    );
  }
}
