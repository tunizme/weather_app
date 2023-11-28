import 'package:tiengviet/tiengviet.dart';

class CityData {
  final String name;
  final double lat;
  final double lon;

  CityData({required this.name, required this.lat, required this.lon});
  factory CityData.fromJson(Map<String, dynamic> json) {
    return CityData(
        name: TiengViet.parse(json['name']),
        lat: json['lat'],
        lon: json['lon']);
  }
}
