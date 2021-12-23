import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';

class Locator extends StatefulWidget {
  const Locator({Key? key}) : super(key: key);

  @override
  _LocatorState createState() => _LocatorState();
}

class _LocatorState extends State<Locator> {
  @override
  void initState() {
    super.initState();
    _getLocation();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
  var locationnns;
  _getLocation() async
  {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    debugPrint('location: ${position.latitude}');
    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    locationnns=("${first.featureName} : ${first.addressLine}");
    print(locationnns);

  }
}
