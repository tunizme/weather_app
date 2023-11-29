import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/models/city.dart';
import 'package:weather_app/models/location_model.dart';
import 'package:weather_app/models/weather_data_current.dart';
import 'package:weather_app/models/weather_data_daily.dart';
import 'package:weather_app/models/weather_data_hourly.dart';
import 'package:weather_app/pages/manage_cities_page.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/widgets/current_weather.dart';
import 'package:weather_app/widgets/daily_weather_widget.dart';
import 'package:weather_app/widgets/hourly_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

CityData? _cityData;
List<City> cities = [];

class _HomePageState extends State<HomePage> {
  bool _isLoading = true;
  final _weatherService = WeatherService('d8591a8ab96509c8bff12086028efeca');
  WeatherDataCurrent? _weatherDataCurrent;
  WeatherDataHourly? _weatherDataHourly;
  WeatherDataDaily? _weatherDataDaily;

  _fetchRealLocation() async {
    final cityData = await _weatherService.getLocation();
    setState(() {
      City.addCity(cityData);
      _cityData = cityData;
      _fetchLocation(_cityData!);
    });
  }

  _fetchLocation(CityData newCityData) async {
    setState(() {
      _cityData = newCityData;

      _fetchWeather();
    });
  }

  _fetchWeather() async {
    final weatherData = await _weatherService.getWeather(_cityData);
    setState(() {
      _weatherDataCurrent = weatherData.getCurrentWeather();
      _weatherDataHourly = weatherData.getHourlyWeather();
      _weatherDataDaily = weatherData.getDailyWeather();
      _cityData = weatherData.getCityData();
      _isLoading = false;
    });
  }

  @override
  void initState() {
    setState(() {
      cities = City.getCities();
    });
    if (cities.isNotEmpty) {
      _cityData = cities[cities.length - 1].cityData;
    }

    if (cities.isEmpty) {
      _fetchRealLocation();
    } else {
      _fetchLocation(_cityData!);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Scaffold(
            backgroundColor: Colors.white,
            body: Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(color: Colors.black),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              titleSpacing: 0,
              elevation: 0.0,
              leading: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const ManageCitiesPage()));
                },
              ),
              title: Text(
                _cityData!.name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              ),
              actions: [
                DropdownButtonHideUnderline(
                  child: DropdownButton(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      icon: const Icon(Icons.arrow_drop_down),
                      dropdownColor: Colors.cyanAccent,
                      iconSize: 36,
                      elevation: 10,
                      padding: const EdgeInsets.only(right: 10),
                      items: cities.map((City location) {
                        return DropdownMenuItem(
                            value: location.cityData,
                            child: Text(location.cityData.name));
                      }).toList(),
                      onChanged: (CityData? newValue) {
                        setState(() {
                          _cityData = newValue!;
                          _isLoading = true;
                          _fetchWeather();
                        });
                      }),
                )
              ],

              //our location dropdown
            ),
            body: SafeArea(
              child: Center(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    CurrentWeatherWidget(
                        weatherDataCurrent: _weatherDataCurrent),
                    const SizedBox(
                      height: 80,
                    ),
                    HourlyWeatherWidget(weatherDataHourly: _weatherDataHourly),
                    const SizedBox(
                      height: 80,
                    ),
                    DailyWeatherWidget(
                      weatherDataDaily: _weatherDataDaily,
                    )
                  ],
                ),
              ),
            ));
  }
}
