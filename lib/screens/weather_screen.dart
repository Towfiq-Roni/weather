// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:location/location.dart';
// // import 'package:geocode/geocode.dart';
// // import 'package:geocoding/geocoding.dart' as geocode;
//
// class WeatherScreen extends StatefulWidget {
//   const WeatherScreen({Key? key}) : super(key: key);
//
//   @override
//   State<WeatherScreen> createState() => _WeatherScreenState();
// }
//
// class _WeatherScreenState extends State<WeatherScreen> {
//   // late Position _currentPosition;
//   LocationData? currentLocation;
//   String address = "";
//   String description = "";
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Weather'),
//       ),
//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         decoration: const BoxDecoration(
//             image: DecorationImage(
//           image: AssetImage("assets/images/day_background.webp"),
//           fit: BoxFit.cover,
//         )),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               if (currentLocation != null)
//                 Text('Location: ${currentLocation?.latitude},'
//                   ' ${currentLocation?.longitude}'),
//               Text(description),
//               Text(address),
//               // Text('Location: ${currentLocation?.latitude},'
//               //     ' ${currentLocation?.longitude}'),
//               // ElevatedButton(onPressed: () {
//               //   _getLocation();
//               // }, child: Text('Location')),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   void initState() {
//     // void getLocation(){
//     super.initState();
//
//     ///Location and Address
//     _getCurrentLocation().then((value) {
//       // _getCurrentLocation().then((location) {
//       LocationData? location = value;
//       // _getWeather(location?.latitude, location?.longitude).then((weather) {
//       _getAddress(location?.latitude, location?.longitude).then((value) {
//           _getWeather(location?.latitude, location?.longitude).then((weather) {
//         setState(() {
//           currentLocation = location;
//           address = value;
//           description = weather;
//         });
//       });
//     });
//     });
//     ///Location, Address and Weather
//     // _getCurrentLocation().then((value) {
//     // _getCurrentLocation().then((location) {
//     // LocationData? location = value;
//     // _getAddress(location?.latitude, location?.longitude).then((value) {
//     //   _getWeather(location?.latitude, location?.longitude).then((weather) {
//     //     setState(() {
//     //       currentLocation = location;
//     //       address = value;
//     //       description = weather;
//     //     });
//     //   });
//     // });
//     // });
//   }
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
//     return "${address.city}, ${address.countryName},"
//         " ${address.postal}";
//   }
//
//   Future<String> _getWeather(double? lati, double? longt) async {
//     String api = 'https://api.openweathermap.org/data/2.5/weather';
//     String appID = '81c3b74680bb8bd275f8f4abf2d3dcf7';
//     String baseUrl = '$api?lat=$lati&lon=$longt&appid=$appID';
//
//     http.Response response = await http.get(Uri.parse(baseUrl));
//     Map parsed = json.decode(response.body);
//
//     return parsed['list'][0]['weather'][0]['description'];
//   }
// }
