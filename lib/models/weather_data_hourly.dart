class WeatherDataHourly {
  List<Hourly> hourly;
  WeatherDataHourly({required this.hourly});
  factory WeatherDataHourly.fromJson(Map<String, dynamic> json) =>
      WeatherDataHourly(
          hourly:
              List<Hourly>.from(json['hourly'].map((e) => Hourly.fromJson(e))));
}

class Hourly {
  int? dt;
  int? temp;
  Hourly({
    this.dt,
    this.temp,
  });
  factory Hourly.fromJson(Map<String, dynamic> json) => Hourly(
        dt: json['dt'] as int?,
        temp: (json['temp'] as num?)?.round(),
      );
  Map<String, dynamic> toJson() => {
        'dt': dt,
        'temp': temp,
      };
}
