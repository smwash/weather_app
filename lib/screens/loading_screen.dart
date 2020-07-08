import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:weather_app/services/weather.dart';

import 'location_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    var weatherData = await WeatherModel().getLocationWeather();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationScreen(
          locationWeather: weatherData,
        ),
      ),
    );
  }

  // void showStatusCode() async {
  //   Location location = Location();
  //   await location.getCurrentLocation();
  //   latitude = location.latitude;
  //   longitude = location.longitude;
  //   http.Response responsetest = await http.get(
  //       // 'api.openweathermap.org/data/2.5/weather?q=London,uk&APPID=dfb5efd6108d6d1aedded225c8e7b17e'
  //       'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey');
  //   print(responsetest.body);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 70.0,
        ),
      ),
    );
  }
}
