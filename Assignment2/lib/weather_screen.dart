import 'package:flutter/material.dart';
import 'weather_api.dart';
import 'weather_data.dart';
import 'weather_details.dart';
import 'package:intl/intl.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Future<WeatherData?> weatherData;
  String selectedCity = 'Mumbai'; // Default city

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  void fetchWeather() {
    setState(() {
      weatherData = WeatherApi().fetchWeather(selectedCity);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildTopBar(),
          Expanded(
            child: FutureBuilder<WeatherData?>(
              future: weatherData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.data == null) {
                  return Center(child: Text('No data found'));
                } else {
                  return WeatherDetails(weather: snapshot.data!);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, left: 16, right: 16),
      color: Colors.blueAccent[100],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedCity,
              dropdownColor: Colors.blue,
              icon: Icon(Icons.arrow_drop_down, color: Colors.white),
              iconSize: 24,
              style: TextStyle(color: Colors.white, fontSize: 20),
              onChanged: (String? newValue) {
                selectedCity = newValue!;
                fetchWeather();
              },
              items: <String>['Mumbai', 'New York', 'Tokyo', 'London', 'Montreal']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
