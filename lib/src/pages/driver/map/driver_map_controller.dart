import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as location;
import 'package:uber_clone/src/utils/snackbar.dart' as utils;

class DriverMapController {
  late BuildContext context;

  GlobalKey<ScaffoldMessengerState> key = GlobalKey<ScaffoldMessengerState>();
  CameraPosition initialPosition =
      const CameraPosition(target: LatLng(9.1809062, 105.1561912), zoom: 14.0);

  late Position _position;
  late StreamSubscription<Position> _positionStream;

  final Completer<GoogleMapController> _mapController = Completer();

  Future<void> init(BuildContext context) async {
    this.context = context;
    checkGPS();
  }

  void onMapCreated(GoogleMapController controller) {
    _mapController.complete(controller);
  }

  void updateLocation() async {
    try {
      await _determinePosition();
      _position = (await Geolocator.getLastKnownPosition())!;

      if (_position != null) {
        centerPosition();
      } else {
        _position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best);
        centerPosition();
      }

      _positionStream = Geolocator.getPositionStream(
              locationSettings: const LocationSettings(
                  accuracy: LocationAccuracy.best, distanceFilter: 1))
          .listen((Position position) {
        _position = position;
        animateCameraToPosition(_position.latitude, _position.longitude);
      });
    } catch (error) {
      print('Error: $error');
    }
  }

  void centerPosition() {
    if (_position != null) {
      animateCameraToPosition(_position.latitude, _position.longitude);
    } else {
      utils.SnackBarCustom.showSnackBar(context, key, 'Active GPS');
    }
  }

  void checkGPS() async {
    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (isLocationEnabled) {
      print('LOCATION GPS ACTIVE');
      updateLocation();
    } else {
      print('GPS DISACTIVE');
      bool locationGPS = await location.Location().requestService();

      if (locationGPS) {
        updateLocation();
        print('ACTIVE GPS');
      }
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Future<void> animateCameraToPosition(
      double latitude, double longitude) async {
    GoogleMapController controller = await _mapController.future;
    if (controller != null) {
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          bearing: 0, target: LatLng(latitude, longitude), zoom: 17)));
    }
  }
}
