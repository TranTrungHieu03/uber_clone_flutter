import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:uber_clone/src/pages/home/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController _con = HomeController();

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
    return Scaffold(
        backgroundColor: Colors.grey[700],
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.yellow, Colors.deepOrange, Colors.pink])),
            child: Column(
              children: [
                _bannerApp(context),
                const SizedBox(height: 50),
                const Text(
                  'Select role',
                  style: TextStyle(color: Colors.white, fontSize: 26),
                ),
                const SizedBox(height: 30),
                _imageCustom(
                    context, 'assets/img/icons8-customer-100.png', 'client'),
                _textCustom('Passenger'),
                const SizedBox(height: 20),
                _imageCustom(
                    context, 'assets/img/icons8-driver-60.png', 'driver'),
                _textCustom('Driver')
              ],
            ),
          ),
        ));
  }

  Widget _bannerApp(BuildContext context) {
    return ClipPath(
      clipper: DiagonalPathClipperTwo(),
      child: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height * 0.25,
        child: Row(
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
                  fontSize: 50, wordSpacing: 8, fontWeight: FontWeight.w700),
            )
          ],
        ),
      ),
    );
  }

  Widget _imageCustom(BuildContext context, String url, String typeUser) {
    return GestureDetector(
      onTap: () => _con.goToLoginPage(typeUser),
      child: CircleAvatar(
        backgroundImage: AssetImage(url),
        radius: 50,
        backgroundColor: Colors.deepOrange[300],
      ),
    );
  }

  Widget _textCustom(String content) {
    return Text(
      content,
      style: const TextStyle(color: Colors.white, fontSize: 16),
    );
  }
}
