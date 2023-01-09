// class WeatherAPI {
//   static const String api =
//       'https://api.openweathermap.org/data/2.5/weather?';
//   static const String appID = '81c3b74680bb8bd275f8f4abf2d3dcf7';
//   static const String lati = '23.7984';
//   static const String long = '90.4031';
//   static const String baseUrl = '$api?lat=$lati&lon=$long&APPID=$appID?';
// }

import 'dart:core';

class WeatherApiConstant {
  // static double? latitude = 23.8103;
  // static double? longitude = 90.4125;
  // static String api = 'https://api.openweathermap.org/data/2.5/weather';
  static String appID = '81c3b74680bb8bd275f8f4abf2d3dcf7';
  // static String baseUrl = '$api?lat=$latitude&lon=$longitude&APPID=$appID';
  static String weatherUrl(double? lat, double? long) =>
      "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&APPID=$appID";
}


// class LocationApiConstant{
//   static double? latitude = 23.8103;
//   static double? longitude = 90.4125;
//   static String api = 'http://api.openweathermap.org/geo/1.0/reverse';
//   static String appID = '81c3b74680bb8bd275f8f4abf2d3dcf7';
//   static String baseUrl = '$api?lat=$latitude&lon=$longitude&APPID=$appID';
// }
