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
      // extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.cyan,
        elevation: 0,
        title: Text('Weather', style: TextStyle(color: Colors.black87,
            fontWeight:FontWeight.w900)),
      ),
      body: Column(
        children: [
          Container(
            child: Row(
              children: [
                FutureBuilder(
                    future: _getWeather(
                        locationData?.latitude, locationData?.longitude),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      // final _temp = snapshot.data![0];
                      // final _city = snapshot.data![1];
                      if(!snapshot.hasData){
                        return Center(child: CircularProgressIndicator(),);
                      }
                      print(snapshot.data);
                      // if(int.parse(snapshot.data) < 15) {
                      //   return Container(
                      //     width: 10,
                      //     height: 10,
                      //     decoration: const BoxDecoration(
                      //       image: DecorationImage(
                      //         image: AssetImage("assets/images/day_background.webp"),
                      //         fit: BoxFit.cover,
                      //       )),);
                      // }
                      // else
                      // {
                      //   print(snapshot.data![0]);
                      //   // return Text(_weather);
                      //   // return ElevatedButton(onPressed:() async{
                      //   //   _getWeather(locationData?.latitude, locationData?.longitude);
                      //   // }, child: Text('Weather'));
                      // }
                      return Text('Weather ${snapshot.data}');
                    }),
                Spacer(flex: 1,),
                FutureBuilder(
                    future: _getCity(
                        locationData?.latitude, locationData?.longitude),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      // final _temp = snapshot.data![0];
                      // final _city = snapshot.data![1];
                      if(!snapshot.hasData){
                        return Center(child: CircularProgressIndicator(),);
                      }
                      print(snapshot.data);
                      // else
                      // {
                      //   print(snapshot.data![0]);
                      //   // return Text(_weather);
                      //   // return ElevatedButton(onPressed:() async{
                      //   //   _getWeather(locationData?.latitude, locationData?.longitude);
                      //   // }, child: Text('Weather'));
                      // }
                      return Text('City ${snapshot.data}');
                    }),
              ],
            ),
          ),
        ],
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
    var weatherInfo = parsed['main']['temp'];
    return (weatherInfo-273.15).toStringAsFixed(2);
  }

  Future<String> _getCity(double? latitude, double? longitude) async {
    String api = 'http://api.openweathermap.org/geo/1.0/reverse';
    String appID = '81c3b74680bb8bd275f8f4abf2d3dcf7';
    String baseUrl = '$api?lat=$latitude&lon=$longitude&APPID=$appID';

    http.Response response = await http.get(Uri.parse(baseUrl));
    List<dynamic> parsed = json.decode(response.body);
    var cityName = parsed[0]['name'];
    return cityName.toString();
  }
}
