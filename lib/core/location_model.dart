// import 'dart:html';
//
// import 'package:flutter/material.dart';
// import 'package:geocode/geocode.dart';
// import 'package:location/location.dart';
//
// class LocationModel with ChangeNotifier{
//
//   Future _getCurrentLocation() async {
//     Location location = new Location();
//     bool _serviceEnabled;
//     LocationData _locationData;
//     PermissionStatus _permissionGranted;
//
//     _serviceEnabled = await location.serviceEnabled();
//     if (!_serviceEnabled) {
//       _serviceEnabled = await location.requestService();
//       if (!_serviceEnabled) {
//         return null;
//       }
//     }
//     _permissionGranted = await location.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//       _permissionGranted = await location.requestPermission();
//       if (_permissionGranted != PermissionStatus.granted) {
//         return null;
//       }
//     }
//
//     _locationData = await location.getLocation();
//     notifyListeners();
//
//     return _locationData;
//     // Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best,
//     // forceAndroidLocationManager: true)
//     // .then((Position position){
//     //   setState(() {
//     //     _currentPosition = position;
//     //   });
//     // }).catchError((e){
//     //   print(e);
//     // });
//   }
//
//   Future<String> _getAddress(double? lat, double? long) async {
//     if (lat == null || long == null) return "";
//     GeoCode geoCode = GeoCode();
//     Address address =
//         await geoCode.reverseGeocoding(latitude: lat, longitude: long);
//     notifyListeners();
//     return "${address.streetAddress}, ${address.city}, ${address.countryName},"
//         " ${address.postal}";
//   }
// }
