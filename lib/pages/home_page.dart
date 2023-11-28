import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/model/index.dart';
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

class _HomePageState extends State<HomePage> {
  bool _isLoading = true;
  final _weatherService = WeatherService('d8591a8ab96509c8bff12086028efeca');
  WeatherDataCurrent? _weatherDataCurrent;
  WeatherDataHourly? _weatherDataHourly;
  WeatherDataDaily? _weatherDataDaily;
  var selectedCities = City.getCities();
  List<City> cities = [];

  _fetchRealLocation() async {
    final cityData = await _weatherService.getLocation();
    setState(() {
      _cityData = cityData;
      _fetchLocation(_cityData!);
    });
  }

  _fetchLocation(CityData newCityData) async {
    setState(() {
      _cityData = newCityData;
      City.addCity(_cityData!);
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
    if (selectedCities.isEmpty) {
      _fetchRealLocation();
    } else {
      _fetchLocation(_cityData!);
    }
    for (int i = 0; i < selectedCities.length; i++) {
      cities.add(selectedCities[i]);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return _isLoading
        ? const SizedBox(
            width: 20,
            height: 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [CircularProgressIndicator()],
            ),
          )
        : Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              titleSpacing: 0,
              backgroundColor: Colors.white,
              elevation: 0.0,
              leading: Consumer<Index>(builder: (context, index, child) {
                return IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const ManageCitiesPage()));
                    setState(() {
                      _cityData = cities[index.getIndex].cityData;
                      _fetchLocation(_cityData!);

                      _fetchWeather();
                    });
                    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //     content:
                    //         Text(result ?? "User doesn't press anything")));
                  },
                );
              }),
              title: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //Our profile image
                    Text(_cityData!.name),
                    //our location dropdown
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 4,
                        ),
                        DropdownButtonHideUnderline(
                          child: DropdownButton(
                              icon: const Icon(Icons.arrow_drop_down),
                              iconDisabledColor: Colors.white,
                              iconSize: 40,
                              elevation: 10,
                              padding: const EdgeInsets.only(left: 0),
                              items: cities.map((City location) {
                                return DropdownMenuItem(
                                    value: location.cityData,
                                    child: Text(location.cityData.name));
                              }).toList(),
                              onChanged: (CityData? newValue) {
                                setState(() {
                                  _cityData = newValue!;
                                  _fetchWeather();
                                });
                              }),
                        )
                      ],
                    )
                  ],
                ),
              ),
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
