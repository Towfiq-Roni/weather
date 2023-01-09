import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import 'package:weather/const/api/api_constants.dart';

import '../model/weather_model.dart';

class ApiServiceWeather {
  Future<WeatherModel?> getWeather(double lat, double long) async{
    try{
      var url = Uri.parse(WeatherApiConstant.weatherUrl(lat, long));
 Response response = await get(url);
      if(response.statusCode == 200){
        WeatherModel weatherModel = WeatherModel.fromJson(jsonDecode(response.body));

        print("========================${weatherModel.main!.temp}");
        return weatherModel;
      }
    } catch(e){
      log(e.toString());
    }
  }
}

// class ApiServiceLocation {
//   Future<List<WeatherModel>?> getWeather() async{
//     try{
//       var url = Uri.parse(WeatherApiConstant.baseUrl);
//       var response = await http.get(url);
//       if(response.statusCode == 200){
//         // List<WeatherModel> _model = weatherModelFromJson(response.body);
//         return _model;
//       }
//     } catch(e){
//       log(e.toString());
//     }
//   }
// }