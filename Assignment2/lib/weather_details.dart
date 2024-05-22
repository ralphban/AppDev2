import 'package:flutter/material.dart';
import 'weather_data.dart';
import 'package:intl/intl.dart';

class WeatherDetails extends StatelessWidget {
  final WeatherData weather;

  WeatherDetails({required this.weather});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('EEEE, MMM d').format(DateTime.parse(weather.currentDate));
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blue.shade300, Colors.blue.shade800],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            weather.city,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            formattedDate,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          Spacer(),
          Icon(Icons.wb_sunny, size: 100, color: Colors.yellow),
          Text(
            '${weather.temperature}°C',
            style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            weather.description,
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          Spacer(),
          Divider(color: Colors.white54),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _weatherInfo(Icons.air, '${weather.windSpeed} km/h'),
                _weatherInfo(Icons.opacity, '${weather.humidity}%'),
                _weatherInfo(Icons.grain, '${weather.pressure} hPa'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _weatherInfo(IconData icon, String data) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 28),
        SizedBox(height: 8),
        Text(data, style: TextStyle(color: Colors.white, fontSize: 18)),
      ],
    );
  }
}
