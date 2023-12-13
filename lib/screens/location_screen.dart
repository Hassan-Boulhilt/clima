import 'package:clima/screens/city_screen.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';

import '../services/weather.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key, required this.weatherData});
  final dynamic weatherData;

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  double? temperature;
  String? weatherIcon;
  String? weatherMessage;
  String? cityName;
  WeatherModel weatherModel = WeatherModel();

  void updateUi(weatherData) {
    temperature = weatherData['current']['temp_c'];
    int condition = weatherData['current']['condition']['code'];
    cityName = weatherData['location']['name'];
    weatherIcon = weatherModel.getWeatherIcon(condition);
    weatherMessage = weatherModel.getMessage(temperature!.toInt());
  }

  @override
  void initState() {
    updateUi(widget.weatherData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherData = await weatherModel.getLocationWeather();
                      setState(() {
                        updateUi(weatherData);
                      });
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CityScreen(),
                        ),
                      );
                      if (typedName != null) {
                        var weatherData =
                            await weatherModel.getWeatherCity(typedName);
                        setState(() {
                          updateUi(weatherData);
                        });
                      }
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '${temperature?.toInt()}',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon!,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  '${weatherMessage!} in ${cityName!}!',
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
