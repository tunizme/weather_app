import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/location_model.dart';
import 'package:weather_app/models/weather_data.dart';
import 'package:weather_app/models/weather_data_current.dart';
import 'package:weather_app/models/weather_data_daily.dart';
import 'package:weather_app/models/weather_data_hourly.dart';

class WeatherService {
  static const baseUrlWeather =
      'https://api.openweathermap.org/data/3.0/onecall';
  static const baseUrlLocation =
      'http://api.openweathermap.org/geo/1.0/reverse';
  final String apiKey;
  WeatherService(this.apiKey);
  WeatherData? weatherData;

  Future<CityData> getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    final response = await http.get(Uri.parse(
        '$baseUrlLocation?lat=${position.latitude}&lon=${position.longitude}&appid=$apiKey'));
    final jsonresponse = jsonDecode(response.body);
    final cityData = jsonresponse[0];
    return CityData.fromJson(cityData);
  }

  Future<WeatherData> getWeather(var cityData) async {
    final lat = cityData.lat;
    final lon = cityData.lon;
    final responseData = await http.get(Uri.parse(
        '$baseUrlWeather?lat=$lat&lon=$lon&appid=$apiKey&units=metric'));
    final jsonresponseData = jsonDecode(responseData.body);
    weatherData = WeatherData(
        WeatherDataCurrent.fromJson(jsonresponseData),
        WeatherDataHourly.fromJson(jsonresponseData),
        WeatherDataDaily.fromJson(jsonresponseData),
        cityData);

    return weatherData!;
  }
}
