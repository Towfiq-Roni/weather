import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:weather/const/api/api_constants.dart';
import 'package:weather/core/networking.dart';
import 'package:weather/model/weather_model.dart';

class WeatherScreenTrial extends StatefulWidget {
  // WeatherModel? weatherData;
  const WeatherScreenTrial({Key? key}) : super(key: key);

  @override
  State<WeatherScreenTrial> createState() => _WeatherScreenTrialState();
}

class _WeatherScreenTrialState extends State<WeatherScreenTrial> {
  LocationData? locationData;
  WeatherModel? weatherData;

  // String _weather = '';
  // late List<WeatherModel>? _weatherModel = [];

  // @override
  // void initState() {
  //   // void getLocation(){
  //   super.initState();
  //   _getCurrentLocation().then((value) {
  //     LocationData? location = value;
  //     // _getWeather(location?.latitude, location?.longitude).then((weather) {
  //     setState(() {
  //       locationData = value;
  //       // _weather = weather;
  //       // });
  //     });
  //   });
  // }

  // @override
  // void initState() {
  //   // int  i = 0;
  //   // void getLocation(){
  //   // WeatherModel? weatherData;
  //   super.initState();
  //   // _getCurrentLocation().then((value) {
  //   //   setState(() {
  //   //     locationData = value;
  //   //     // widget.
  //   //     // WeatherModel? weatherData;
  //   //   });
  //
  //   });
  //   }

  // void _getData() async{
  //   _weatherModel = (await ApiServiceWeather().getWeather())!;
  //   Future.delayed(
  //       const Duration(seconds: 2))
  //       .then((value) => setState(() {}));
  // }

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
  // }

  String getCelcius(double temp) {
    temp -= 273.15;
    return temp.toStringAsFixed(2);
  }

  // @override
  // void initState() {
  //   // bool time = true;
  //   final now = DateTime.now();
  //   WeatherModel? weatherData;
  //   super.initState();
  //
  //     setState(() {
  //       if(now.compareTo(_getClockInUTCPlus6Hours(weatherData?.sys!.sunset!)) == 0){
  //
  //       }
  //     });
  //   }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    // var len = weatherData!.main;
    // Response weatherResponse;
    // WeatherModel? weatherData;
    // = await ApiServiceWeather().getWeather(locationData!.latitude, locationData!.longitude);
    return Scaffold(
      backgroundColor: Colors.white,
      // extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: weatherData?.weather![0].description! != 'haze'
            ? Colors.white
            : Colors.blueGrey,
        elevation: 0,
        title: Text(
          'Weather',
          style: GoogleFonts.acme(
              textStyle: TextStyle(
                  color: weatherData?.weather![0].description! != 'haze'
                      ? Colors.black87
                      : Colors.white,
                  fontWeight: FontWeight.w500)),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: weatherData?.weather![0].description! != 'haze'
              ? Colors.white
              : Colors.blueGrey,
        ),
        padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: weatherData?.weather![0].description! != 'haze'
                    ? AssetImage("assets/images/day.gif")
                    : AssetImage("assets/images/night.gif"),
                fit: BoxFit.fill,
              )),
              child: Container(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        weatherData != null
                            ? Text(
                                '${getCelcius(weatherData!.main!.temp!)}°C',
                                style: GoogleFonts.blackOpsOne(
                                  fontSize: 28,
                                    color:
                                    weatherData?.weather![0].description! != 'haze'
                                        ? Colors.black87
                                        : Colors.deepOrange.shade500
                                ),
                              )
                            : Text(
                                'Empty',
                                style: GoogleFonts.blackOpsOne(
                                  fontSize: 28,
                                    color:
                                    weatherData?.weather![0].description! != 'haze'
                                        ? Colors.black87
                                        : Colors.deepOrange.shade500
                                ),
                              ),
                        weatherData != null
                            ? Text(
                                'Feels like: ${getCelcius(weatherData!.main!.feelsLike!)}°C',
                                style: GoogleFonts.blackOpsOne(
                                  fontSize: 16,
                                    color:
                                    weatherData?.weather![0].description! != 'haze'
                                        ? Colors.black87
                                        : Colors.deepOrange.shade500
                                ),
                              )
                            : Text(
                                'Empty',
                                style: GoogleFonts.blackOpsOne(
                                  fontSize: 16,
                                    color:
                                    weatherData?.weather![0].description! != 'haze'
                                        ? Colors.black87
                                        : Colors.deepOrange.shade500
                                ),
                              ),
                      ],
                    ),
                    // GestureDetector(
                    //   onTap:() async{
                    //     locationData = await _getCurrentLocation();
                    //     if(locationData != null){
                    //       WeatherModel? weatherResponse = await ApiServiceWeather()
                    //           .getWeather(locationData!.latitude!, locationData!.longitude!);
                    //       setState(() {
                    //         weatherData = weatherResponse;
                    //       });
                    //     }
                    //     print('location is null');
                    // },
                    //  child: Text("getData"),
                    // ),
                    Spacer(
                      flex: 2,
                    ),
                    Column(
                      children: [
                        weatherData != null
                            ? Text(
                                'Country: ${weatherData?.sys!.country}',
                                style: GoogleFonts.bodoniModa(
                                  fontSize: 20,
                                  color:
                                  weatherData?.weather![0].description! != 'haze'
                                      ? Colors.black87
                                      : Colors.deepOrange.shade500
                                ),
                              )
                            : Text(
                                'Empty',
                                style: GoogleFonts.bodoniModa(
                                  fontSize: 20,
                                    color:
                                    weatherData?.weather![0].description! != 'haze'
                                        ? Colors.black87
                                        : Colors.deepOrange.shade500
                                ),
                              ),
                        weatherData != null
                            ? Text(
                                '${weatherData!.weather![0].main}',
                                style: GoogleFonts.bodoniModa(
                                  fontSize: 24,
                                    // fontWeight: FontWeight.w500,
                                    color:
                                    weatherData?.weather![0].description! != 'haze'
                                        ? Colors.black87
                                        : Colors.deepOrange.shade500
                                ),
                              )
                            : Text(
                                'Empty',
                                style: GoogleFonts.bodoniModa(
                                  fontSize: 20,
                                    color:
                                    weatherData?.weather![0].description! != 'haze'
                                        ? Colors.black87
                                        : Colors.deepOrange.shade500
                                ),
                              ),
                      ],
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    GestureDetector(
                      onTap: () async {
                        locationData = await _getCurrentLocation();
                        if (locationData != null) {
                          WeatherModel? weatherResponse =
                              await ApiServiceWeather().getWeather(
                                  locationData!.latitude!,
                                  locationData!.longitude!);
                          setState(() {
                            weatherData = weatherResponse;
                          });
                        }
                        print('location is null');
                      },
                      child: Icon(Icons.refresh,
                        color: weatherData?.weather![0].description! != 'haze'
                            ? Colors.white
                            : Colors.deepOrange.shade500,),
                    ),
                    // Container(child:
                    // // weatherData!=null?
                    // // CircularProgressIndicator():
                    // Text('ID: ${weatherData?.main!.temp.toString()}'),
                    // // Text({weatherData?.main!.temp}.toString()),
                    // // Text({weatherData?.main!.temp}.toString()),
                    // ),
                  ],
                ),
              ),
            ),
            GridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 4),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 100,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8),
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(8, 4, 8, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: weatherData?.weather![0].description! != 'haze'
                        ? Colors.grey.shade200
                        : Colors.cyan.shade700,
                  ),
                  // color: Colors.grey,
                  child: weatherData != null
                      ? Text(
                          'Maximum temperature: \n${getCelcius(weatherData!.main!.tempMax!)}°C',
                          style: GoogleFonts.bodoniModa(
                            fontSize: 20,
                            color: weatherData?.weather![0].description! != 'haze'
                                ? Colors.black
                                : Colors.white,
                          ),
                        )
                      : Text(
                          'Empty',
                          style: GoogleFonts.bodoniModa(
                            fontSize: 20,
                            color: weatherData?.weather![0].description! != 'haze'
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(8, 4, 8, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: weatherData?.weather![0].description! != 'haze'
                        ? Colors.grey.shade200
                        : Colors.cyan.shade700,
                  ),
                  // color: Colors.grey,
                  child: weatherData != null
                      ? Text(
                          'Minimum temperature: \n${getCelcius(weatherData!.main!.tempMin!)}°C',
                          style: GoogleFonts.bodoniModa(
                            fontSize: 20,
                            color: weatherData?.weather![0].description! != 'haze'
                                ? Colors.black
                                : Colors.white,
                          ),
                        )
                      : Text(
                          'Empty',
                          style: GoogleFonts.bodoniModa(
                            fontSize: 20,
                            color: weatherData?.weather![0].description! != 'haze'
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(8, 4, 8, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: weatherData?.weather![0].description! != 'haze'
                        ? Colors.grey.shade200
                        : Colors.cyan.shade700,
                  ),
                  // color: Colors.grey,
                  child: weatherData != null
                      ? Text(
                          'Pressure: \n${weatherData!.main!.pressure}',
                          style: GoogleFonts.bodoniModa(
                            fontSize: 20,
                            color: weatherData?.weather![0].description! != 'haze'
                                ? Colors.black
                                : Colors.white,
                          ),
                        )
                      : Text(
                          'Empty',
                          style: GoogleFonts.bodoniModa(
                            fontSize: 20,
                            color: weatherData?.weather![0].description! != 'haze'
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(8, 4, 8, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: weatherData?.weather![0].description! != 'haze'
                        ? Colors.grey.shade200
                        : Colors.cyan.shade700,
                  ),
                  // color: Colors.grey,
                  child: weatherData != null
                      ? Text(
                          'Humidity: \n${weatherData!.main!.humidity}',
                          style: GoogleFonts.bodoniModa(
                            fontSize: 20,
                            color: weatherData?.weather![0].description! != 'haze'
                                ? Colors.black
                                : Colors.white,
                          ),
                        )
                      : Text(
                          'Empty',
                          style: GoogleFonts.bodoniModa(
                            fontSize: 20,
                            color: weatherData?.weather![0].description! != 'haze'
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                ),
              ],
            ),
            GridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 4),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 75,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8),
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(8, 4, 8, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: weatherData?.weather![0].description! != 'haze'
                        ? Colors.grey.shade200
                        : Colors.cyan.shade700,
                  ),
                  // color: Colors.grey,
                  child: weatherData != null
                      ? Text(
                          'Sunrise \n${_getClockInUTCPlus6Hours(weatherData!.sys!.sunrise!)}',
                          style: GoogleFonts.bodoniModa(
                            fontSize: 20,
                            color: weatherData?.weather![0].description! != 'haze'
                                ? Colors.black
                                : Colors.white,
                          ),
                        )
                      : Text(
                          'Empty',
                          style: GoogleFonts.bodoniModa(
                            fontSize: 20,
                            color: weatherData?.weather![0].description! != 'haze'
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(8, 4, 8, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: weatherData?.weather![0].description! != 'haze'
                        ? Colors.grey.shade200
                        : Colors.cyan.shade700,
                  ),
                  // color: Colors.grey,
                  child: weatherData != null
                      ? Text(
                          'Sunset: \n${_getClockInUTCPlus6Hours(weatherData!.sys!.sunset!)}',
                          style: GoogleFonts.bodoniModa(
                            fontSize: 20,
                            color: weatherData?.weather![0].description! != 'haze'
                                ? Colors.black
                                : Colors.white,
                          ),
                        )
                      : Text(
                          'Empty',
                          style: GoogleFonts.bodoniModa(
                            fontSize: 20,
                            color: weatherData?.weather![0].description! != 'haze'
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                ),
              ],
            )
            // Container(
            //   height: MediaQuery.of(context).size.height / 4,
            //   child: FutureBuilder(
            //       future:
            //           _getSun(locationData?.latitude, locationData?.longitude),
            //       builder: (BuildContext context, AsyncSnapshot snapshot) {
            //         if (!snapshot.hasData) {
            //           return Center(
            //             child: CircularProgressIndicator(),
            //           );
            //         }
            //         // print(_getClockInUTCPlus6Hours(_weatherModel![0].sys?.sunset) as int);
            //         print(snapshot.data);
            //         // else
            //         // {
            //         //   print(snapshot.data![0]);
            //         //   // return Text(_weather);
            //         //   // return ElevatedButton(onPressed:() async{
            //         //   //   _getWeather(locationData?.latitude, locationData?.longitude);
            //         //   // }, child: Text('Weather'));
            //         // }
            //         return Text('Sunset ${snapshot.data}',
            //             style: GoogleFonts.bodoniModa(
            //               textStyle: TextStyle(
            //                 color: Colors.black87,
            //                 fontSize: 20,
            //                 fontWeight: FontWeight.w500,
            //               ),
            //             ));
            //       }),
            // )
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

  // void data() async{
  //     WeatherModel? weatherData = await ApiServiceWeather()
  //         .getWeather(locationData!.latitude, locationData!.longitude);
  //     setState(() {
  //       // WeatherModel? weatherData;
  //     });
  //     // return weatherData;
  // }

  //  Future<Response?> _getWeather(double? latitude, double? longitude) async {
  //    // String api = 'https://api.openweathermap.org/data/2.5/weather';
  //    // String appID = '81c3b74680bb8bd275f8f4abf2d3dcf7';
  //    // String baseUrl = '$api?lat=$latitude&lon=$longitude&APPID=$appID';
  // Response response =
  //        await get(Uri.parse(WeatherApiConstant.weatherUrl(latitude, longitude)));
  // if(response.statusCode == 200){
  //   return jsonDecode(response.body);
  // }
  //
  //
  //
  //    // if(response.statusCode == 200) {
  //    //   return jsonDecode(response.body);
  //    // }else{
  //    //   return
  //    // }
  //    // Map parsed = json.decode(response.body);
  //    // var weatherInfo = parsed['main']['temp'];
  //    // return (weatherInfo - 273.15).toStringAsFixed(2);
  //  }

  // Future<String> _getCity(double? latitude, double? longitude) async {
  //   // String api = 'http://api.openweathermap.org/geo/1.0/reverse';
  //   // String appID = '81c3b74680bb8bd275f8f4abf2d3dcf7';
  //   // String baseUrl = '$api?lat=$latitude&lon=$longitude&APPID=$appID';
  //
  //   http.Response response =
  //       await http.get(Uri.parse(LocationApiConstant.baseUrl));
  //   List<dynamic> parsed = json.decode(response.body);
  //   var cityName = parsed[0]['name'];
  //   return cityName.toString();
  // }

  dynamic _getClockInUTCPlus6Hours(int? timeSinceEpochInSec) {
    final time = DateTime.fromMillisecondsSinceEpoch(
            timeSinceEpochInSec! * 1000,
            isUtc: true)
        .add(const Duration(hours: 6));
    return '${time.hour}:${time.minute}';
  }
}
