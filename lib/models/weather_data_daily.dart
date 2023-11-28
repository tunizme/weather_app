class WeatherDataDaily {
  List<Daily> daily;
  WeatherDataDaily({required this.daily});
  factory WeatherDataDaily.fromJson(Map<String, dynamic> json) =>
      WeatherDataDaily(
          daily: List<Daily>.from(json['daily'].map((e) => Daily.fromJson(e))));
}

class Daily {
  int? dt;
  int? sunset;
  int? sunrise;
  int? rain;
  Temp? temp;
  int? humidity;
  double? windSpeed;
  List<Weather>? weather;
  int? clouds;

  Daily(
      {this.dt,
      this.temp,
      this.humidity,
      this.windSpeed,
      this.weather,
      this.clouds,
      this.rain,
      this.sunrise,
      this.sunset});

  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
        dt: json['dt'] as int?,
        sunset: json['sunset'] as int?,
        sunrise: json['sunrise'] as int?,
        rain: (json['rain'] as num?)?.round(),
        temp: json['temp'] == null
            ? null
            : Temp.fromJson(json['temp'] as Map<String, dynamic>),
        humidity: json['humidity'] as int?,
        windSpeed: (json['wind_speed'] as num?)?.toDouble(),
        weather: (json['weather'] as List<dynamic>?)
            ?.map((e) => Weather.fromJson(e as Map<String, dynamic>))
            .toList(),
        clouds: json['clouds'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'dt': dt,
        'sunset': sunset,
        'sunrise': sunrise,
        'rain': rain,
        'temp': temp?.toJson(),
        'humidity': humidity,
        'wind_speed': windSpeed,
        'weather': weather?.map((e) => e.toJson()).toList(),
        'clouds': clouds,
      };
}

class Temp {
  int? day;
  int? min;
  int? max;
  double? night;
  double? eve;
  double? morn;

  Temp({this.day, this.min, this.max, this.night, this.eve, this.morn});

  factory Temp.fromJson(Map<String, dynamic> json) => Temp(
        day: (json['day'] as num?)?.round(),
        min: (json['min'] as num?)?.round(),
        max: (json['max'] as num?)?.round(),
        night: (json['night'] as num?)?.toDouble(),
        eve: (json['eve'] as num?)?.toDouble(),
        morn: (json['morn'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'day': day,
        'min': min,
        'max': max,
        'night': night,
        'eve': eve,
        'morn': morn,
      };
}

class Weather {
  String? main;
  String? icon;
  String? description;
  Weather({
    this.main,
    this.icon,
    this.description,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
      main: json['main'] as String?,
      description: json['description'] as String?,
      icon: json['icon'] as String?);

  Map<String, dynamic> toJson() =>
      {'main': main, 'description': description, 'icon': icon};
}
