import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_clone/src/pages/driver/map/driver_map_controller.dart';
import 'package:uber_clone/src/widgets/button_app.dart';

class DriverMapPage extends StatefulWidget {
  const DriverMapPage({super.key});

  @override
  State<DriverMapPage> createState() => _DriverMapPageState();
}

class _DriverMapPageState extends State<DriverMapPage> {
  final DriverMapController _con = DriverMapController();
  String? _mapStyleString;

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/map/map_style.json').then((string) {
      _mapStyleString = string;
    });
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _con.init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _con.key,
      child: Scaffold(
          body: SafeArea(
        child: Stack(children: [
          _googleMaps(),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [_buttonDrawer(), _buttonCenterPosition()],
              ),
              Expanded(child: Container()),
              _buttonConnect()
            ],
          )
        ]),
      )),
    );
  }

  Widget _buttonCenterPosition() {
    return Container(
      alignment: Alignment.centerRight,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Card(
        shape: const CircleBorder(),
        elevation: 4.0,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: const Icon(
            Icons.location_searching,
            color: Colors.grey,
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget _buttonDrawer() {
    return Container(
      alignment: Alignment.centerLeft,
      child: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.menu,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buttonConnect() {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 30),
      alignment: Alignment.bottomCenter,
      child: ButtonApp(
        text: 'Connect',
        color: Colors.amber,
        textColor: Colors.black,
        onPressed: () => {},
      ),
    );
  }

  Widget _googleMaps() {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _con.initialPosition,
      onMapCreated: _con.onMapCreated,
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      zoomControlsEnabled: true,
      style: _mapStyleString,
    );
  }
}
