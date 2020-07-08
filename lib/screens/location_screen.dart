import 'package:flutter/material.dart';
import 'package:weather_app/screens/city_screen.dart';
import 'package:weather_app/services/weather.dart';
import 'package:weather_app/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  final locationWeather;

  const LocationScreen({this.locationWeather});
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  String weatherIcon;
  int temperature;
  String cityName;
  String weatherMessage;
  String passedCityName;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        AlertDialog(
          title: Text('Error Message'),
          content: Column(
            children: [
              Text('${temperature = 0}'),
              Text('${weatherIcon = 'Error'}'),
              Text('${weatherMessage = 'Unable to load weather Data'}'),
              Text('${cityName = ''}'),
            ],
          ),
        );

        return;
      }
      var condition = weatherData['weather'][0]['id'];
      cityName = weatherData['name'];
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();

      weatherIcon = weather.getWeatherIcon(condition);
      weatherMessage = weather.getMessage(temperature);
    });
  }

  Future<dynamic> foreCast(String cityName) async {
    var weatherData = await weather.getWeatherForeCast(cityName);
    updateUI(weatherData);
    return weatherData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CityScreen(),
                        ),
                      );

                      if (typedName != null) {
                        var weatherData =
                            await weather.getCityWeather(typedName);
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              //   margin: EdgeInsets.all(15.0),
              //   color: Colors.black,
              //   // child: Text(${
              //   //   foreCast(typedName)
              //   // }),
              // ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weatherMessage in $cityName!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
