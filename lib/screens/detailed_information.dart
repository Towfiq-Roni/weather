import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class DetailedInformation extends StatefulWidget {
  const DetailedInformation({Key? key}) : super(key: key);

  @override
  State<DetailedInformation> createState() => _DetailedInformationState();
}

class _DetailedInformationState extends State<DetailedInformation> {

  LocationData? locationData;
  // var gridInfo = [];
  @override
  void initState() {
    super.initState();
    _getCurrentLocation().then((value) {
      LocationData? location = value;
      setState(() {
        locationData = value;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'More Info',
          style: GoogleFonts.acme(
              textStyle: TextStyle(
                  color: Colors.black87, fontWeight: FontWeight.w500)),
        ),
      ),
      // body: FutureBuilder(
      //   future: _getWeather(LocationData?.latitude, LocationData?.longitude),
      //   builder: (BuildContext context, AsyncSnapshot snapshot) {
      //     return GridView.builder(
      //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //           crossAxisCount: 4,
      //           mainAxisExtent: 100,
      //           crossAxisSpacing: 8,
      //           mainAxisSpacing: 8,
      //         ),
      //         itemCount: 4,
      //         itemBuilder: (BuildContext context, int index) {
      //           return Container();
      //         });
      //   }),
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
    var weatherInfo = parsed['main'];
    return weatherInfo;
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
