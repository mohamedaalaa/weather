import 'package:flutter/material.dart';

import '../models/weather.dart';

class WeatherPopulated extends StatelessWidget {
  WeatherPopulated({Key? key, this.weather, required this.value})
      : super(key: key);

  bool value;
  WeatherModel? weather;

  String time = DateTime.now().toString();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        _WeatherBackground(),
        Center(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            clipBehavior: Clip.none,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    weather!.title,
                    style: theme.textTheme.headline2?.copyWith(
                      fontWeight: FontWeight.w200,
                      color: Colors.white
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text("Updated at $time",
                      style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _WeatherIcon(
                          temp: weather!.consolidatedWeather[0].theTemp,
                      ),
                      Text(
                        "${!value ? weather!.consolidatedWeather[0].theTemp.toStringAsFixed(1) : weather!.consolidatedWeather[0].theTemp + 20}",
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Column(
                        children: [
                          Text(
                              "min_temp: ${weather!.consolidatedWeather[0].minTemp.toStringAsFixed(1)}",style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                          Text(
                              "max_temp: ${weather!.consolidatedWeather[0].maxTemp.toStringAsFixed(1)}",style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _WeatherIcon extends StatelessWidget {
  final double temp;
  const _WeatherIcon({Key? key, required this.temp
  }) : super(key: key);

  static const _iconSize = 100.0;

  @override
  Widget build(BuildContext context) {
    return  Text(
      emoji(temp),
      style: const TextStyle(fontSize: _iconSize),
    );
  }
}

String emoji(double temp) {
  if (temp < 5) {
    return  '🌨️';
  } else if (temp>5&&temp<15) {
    return '🌧️';
  } else if (temp>15&&temp<20) {
    return  '☁️';
  } else if (temp>20&&temp<30) {
    return '☀️';
  } else {
    return '☀️';
  }
}
/*
extension on WeatherCondition {
String get toEmoji {
  switch (this) {
    case WeatherCondition.clear:
      return '☀️';
    case WeatherCondition.rainy:
      return '🌧️';
    case WeatherCondition.cloudy:
      return '☁️';
    case WeatherCondition.snowy:
      return '🌨️';
    case WeatherCondition.unknown:
    default:
      return '❓';
  }
}
}
*/

class _WeatherBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.25, 0.75, 0.90, 1.0],
          colors: [
            Colors.blueGrey,
            Colors.blueGrey,
            Colors.blueGrey,
            Colors.blueGrey,
          ],
        ),
      ),
    );
  }
}
