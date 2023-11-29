import 'package:weather_app/models/location_model.dart';

class City {
  CityData cityData;
  City({required this.cityData});

  //List of Cities data
  static List<City> citiesList = [];
  static bool checkContains(String name) {
    for (var i = 0; i < citiesList.length; i++) {
      if (citiesList[i].cityData.name == name) {
        return true;
      }
    }
    return false;
  }

  //Get the selected cities
  static List<City> getCities() => citiesList;
  static addCity(CityData cityData) {
    if (!checkContains(cityData.name)) {
      citiesList.add(City(cityData: cityData));
    }
  }

  static removeCity(City city) {
    if (citiesList.length != 1) {
      citiesList.remove(city);
    }
  }
}
