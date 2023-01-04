import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class WeatherScreenTrial extends StatefulWidget {
  const WeatherScreenTrial({Key? key}) : super(key: key);

  @override
  State<WeatherScreenTrial> createState() => _WeatherScreenTrialState();
}

class _WeatherScreenTrialState extends State<WeatherScreenTrial> {

  LocationData? locationData;
  String _weather = '';

  @override
  void initState() {
    // void getLocation(){
    super.initState();
    _getCurrentLocation().then((value) {
      LocationData? location = value;
      // _getWeather(location?.latitude, location?.longitude).then((weather) {
        setState(() {
          locationData = value;
          // _weather = weather;
        // });
      });
    });


    // _getPosition().then((position){
    //   _getPlacemark(position.latitude, position.longitude).then((value) {
    //     // _getWeather(position.latitude, position.longitude).then((weather) {
    //       setState(() {
    //         _address = value as String;
    //         // _description = weather;
    //       });
    //     });
    //   });
    // });


///Location and Address
//     _getCurrentLocation().then((value) {
//     // _getCurrentLocation().then((location) {
//     LocationData? location = value;
//     // _getWeather(location?.latitude, location?.longitude).then((weather) {
//       _getAddress(location?.latitude, location?.longitude).then((value) {
//     //   _getWeather(location?.latitude, location?.longitude).then((value) {
//         setState(() {
//           currentLocation = location;
//           // address = value;
//           // description = weather;
//         });
//       });
//     });
    // });
///Location, Address and Weather
    // _getCurrentLocation().then((value) {
      // _getCurrentLocation().then((location) {
      // LocationData? location = value;
      // _getAddress(location?.latitude, location?.longitude).then((value) {
      //   _getWeather(location?.latitude, location?.longitude).then((weather) {
      //     setState(() {
      //       currentLocation = location;
      //       address = value;
      //       description = weather;
      //     });
      //   });
      // });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Latitude: ${locationData?.latitude},"
                " Longitude: ${locationData?.longitude}"),
            FutureBuilder(
              future: _getWeather(locationData?.latitude, locationData?.longitude),
                builder: (BuildContext context, AsyncSnapshot snapshot){
                if(snapshot.hasData){
                  print(snapshot.data);
                  return Text(_weather);
                  // return ElevatedButton(onPressed:() async{
                  //   _getWeather(locationData?.latitude, locationData?.longitude);
                  // }, child: Text('Weather'));
                }
                return Text('Weather: $_weather');
                })
            // ElevatedButton(onPressed:() async{
            //   _getWeather(locationData?.latitude, locationData?.longitude);
            // }, child: Text('Weather')),
            // Text('Weather: $_weather'),
          ],
        ),
      ),
    );
  }

  Future _getCurrentLocation() async {
    Location location = Location();
    bool _serviceEnabled;
    LocationData _locationData;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    // if (!_serviceEnabled) {
    //   _serviceEnabled = await location.requestService();
    //   if (!_serviceEnabled) {
    //     return null;
    //   }
    // }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
        // _locationData = await location.getLocation();
      }
    }
    _locationData = await location.getLocation();
    return _locationData;
  }

  Future<String> _getWeather(double? latitude, double? longitude) async {
    String api = 'https://api.openweathermap.org/data/2.5/weather';
    String appID = '81c3b74680bb8bd275f8f4abf2d3dcf7';
    String baseUrl = '$api?lat=$latitude&lon=$longitude&APPID=$appID';

    http.Response response = await http.get(Uri.parse(baseUrl));
    Map parsed = json.decode(response.body);

    return parsed['list'][0]['weather'][0]['description'];
    // as String;
  }
}
