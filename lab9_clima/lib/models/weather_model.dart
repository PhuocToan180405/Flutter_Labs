import 'package:flutter/material.dart';

class WeatherData {
  final String cityName;
  final String country;
  final int temp;
  final int feelsLike;
  final int tempMin;
  final int tempMax;
  final int humidity;
  final double windSpeed;
  final String description;
  final int conditionCode;
  final String iconCode;
  final int timezone;
  final String localTimeString;

  WeatherData({
    required this.cityName,
    required this.country,
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.humidity,
    required this.windSpeed,
    required this.description,
    required this.conditionCode,
    required this.iconCode,
    required this.timezone,
    required this.localTimeString,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    final main = json['main'] as Map<String, dynamic>? ?? {};
    final weatherList = json['weather'] as List<dynamic>? ?? [];
    final weatherFirst = weatherList.isNotEmpty
        ? weatherList[0] as Map<String, dynamic>
        : <String, dynamic>{};
    final wind = json['wind'] as Map<String, dynamic>? ?? {};
    final sys = json['sys'] as Map<String, dynamic>? ?? {};

    final int timezoneOffset = (json['timezone'] as num?)?.toInt() ?? 25200;

    return WeatherData(
      cityName: json['name'] as String? ?? 'Unknown',
      country: sys['country'] as String? ?? 'VN',
      temp: (main['temp'] as num?)?.round() ?? 22,
      feelsLike: (main['feels_like'] as num?)?.round() ?? 22,
      tempMin: (main['temp_min'] as num?)?.round() ?? 20,
      tempMax: (main['temp_max'] as num?)?.round() ?? 24,
      humidity: (main['humidity'] as num?)?.toInt() ?? 80,
      windSpeed: (wind['speed'] as num?)?.toDouble() ?? 1.5,
      description: weatherFirst['description'] as String? ?? 'clear sky',
      conditionCode: (weatherFirst['id'] as num?)?.toInt() ?? 800,
      iconCode: weatherFirst['icon'] as String? ?? '01d',
      timezone: timezoneOffset,
      localTimeString: formatLocalTime(timezoneOffset),
    );
  }

  static String formatLocalTime(int timezoneOffsetInSeconds) {
    final nowUtc = DateTime.now().toUtc();
    final localDateTime = nowUtc.add(Duration(seconds: timezoneOffsetInSeconds));
    final hour = localDateTime.hour;
    final minute = localDateTime.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';
    final formattedHour =
        (hour % 12 == 0 ? 12 : hour % 12).toString().padLeft(2, '0');
    return '$formattedHour:$minute $period local time';
  }

  Widget buildWeatherIcon({double size = 80}) {
    const Color cloudBlue = Color(0xFF29B6F6);
    const Color deepBlue = Color(0xFF0288D1);
    const Color sunYellow = Color(0xFFFFB300);

    if (conditionCode < 300) {
      return Stack(
        alignment: Alignment.center,
        children: [
          Icon(Icons.cloud, size: size, color: deepBlue),
          Positioned(
            bottom: 4,
            child: Icon(Icons.flash_on, size: size * 0.45, color: sunYellow),
          ),
        ],
      );
    } else if (conditionCode < 600) {
      return Stack(
        alignment: Alignment.center,
        children: [
          Icon(Icons.cloud, size: size, color: cloudBlue),
          Positioned(
            bottom: 2,
            child: Icon(Icons.water_drop, size: size * 0.4, color: deepBlue),
          ),
        ],
      );
    } else if (conditionCode < 700) {
      return Icon(Icons.ac_unit, size: size, color: cloudBlue);
    } else if (conditionCode < 800) {
      return Icon(Icons.cloud_queue, size: size, color: cloudBlue);
    } else if (conditionCode == 800) {
      return Icon(Icons.wb_sunny_rounded, size: size, color: sunYellow);
    } else if (conditionCode == 801) {
      return SizedBox(
        width: size * 1.1,
        height: size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: size * 0.05,
              top: size * 0.05,
              child: Icon(
                Icons.wb_sunny,
                size: size * 0.58,
                color: const Color(0xFF29B6F6),
              ),
            ),
            Positioned(
              right: size * 0.02,
              bottom: size * 0.02,
              child: Icon(
                Icons.cloud,
                size: size * 0.72,
                color: const Color(0xFF0288D1),
              ),
            ),
          ],
        ),
      );
    } else {
      return Icon(
        Icons.cloud,
        size: size,
        color: const Color(0xFF29B6F6),
      );
    }
  }
}
