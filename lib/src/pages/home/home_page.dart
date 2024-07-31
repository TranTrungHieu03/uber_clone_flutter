import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:uber_clone/src/pages/home/home_controller.dart';

class HomePage extends StatelessWidget {
  final HomeController _con = HomeController();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    _con.init(context);
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
                _imageCustom(context, 'assets/img/icons8-customer-100.png'),
                _textCustom('Passenger'),
                const SizedBox(height: 20),
                _imageCustom(context, 'assets/img/icons8-driver-60.png'),
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

  Widget _imageCustom(BuildContext context, String url) {
    return GestureDetector(
      onTap: _con.goToLoginPage,
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
