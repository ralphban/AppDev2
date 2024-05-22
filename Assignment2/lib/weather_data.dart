class WeatherData {
  final String description;
  final double temperature;
  final double windSpeed;
  final int chanceOfRain;
  final int humidity;
  final double pressure;
  final String city;
  final String currentDate;

  WeatherData({
    required this.description,
    required this.temperature,
    required this.windSpeed,
    required this.chanceOfRain,
    required this.humidity,
    required this.pressure,
    required this.city,
    required this.currentDate,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    final currentWeather = json['current'];
    final location = json['location'];
    return WeatherData(
      city: location['name'],
      description: currentWeather['weather_descriptions'][0],
      temperature: (currentWeather['temperature'] as num).toDouble(),
      windSpeed: (currentWeather['wind_speed'] as num).toDouble(),
      chanceOfRain: (currentWeather['precip'] as num).toInt(),
      humidity: (currentWeather['humidity'] as num).toInt(),
      pressure: (currentWeather['pressure'] as num).toDouble(),
      currentDate: location['localtime'],
    );
  }
}


