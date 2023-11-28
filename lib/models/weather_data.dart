import 'package:weather_app/models/location_model.dart';
import 'package:weather_app/models/weather_data_current.dart';
import 'package:weather_app/models/weather_data_daily.dart';
import 'package:weather_app/models/weather_data_hourly.dart';

class WeatherData {
  final WeatherDataCurrent current;
  final WeatherDataHourly hourly;
  final WeatherDataDaily daily;
  final CityData cityData;
  WeatherData(this.current, this.hourly, this.daily, this.cityData);

  WeatherDataCurrent getCurrentWeather() => current;
  WeatherDataHourly getHourlyWeather() => hourly;
  WeatherDataDaily getDailyWeather() => daily;
  CityData getCityData() => cityData;
}
