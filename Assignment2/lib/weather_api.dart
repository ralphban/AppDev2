import 'dart:convert';
import 'package:http/http.dart' as http;
import 'constants.dart';
import 'weather_data.dart';

class WeatherApi {
  Future<WeatherData?> fetchWeather(String city) async {
    final queryParameters = {
      'access_key': Constants.apiKey,
      'query': city,
    };
    final uri = Uri.parse(Constants.baseUrl).replace(queryParameters: queryParameters);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return WeatherData.fromJson(jsonDecode(response.body));
    } else {
      print('Failed to load weather data');
      return null;
    }
  }
}
