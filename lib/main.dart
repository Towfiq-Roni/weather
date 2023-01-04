import 'package:flutter/material.dart';
import 'package:weather/screens/weather_screen.dart';
import 'package:weather/screens/weather_screen_gl.dart';
import 'package:weather/screens/weather_screen_trial.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // api = await _getData();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: WeatherScreenTrial(),
    );
  }
}
