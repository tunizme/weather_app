import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_data_current.dart';

class CurrentWeatherWidget extends StatelessWidget {
  final WeatherDataCurrent? weatherDataCurrent;

  const CurrentWeatherWidget({super.key, this.weatherDataCurrent});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Text(
              '${weatherDataCurrent?.current.temp!.round() ?? '0'}',
              style: const TextStyle(
                fontSize: 110,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 140, top: 80),
              child: Opacity(
                opacity: 0.96,
                child: Image.asset(
                    'assets/${weatherDataCurrent?.current.weather![0].icon ?? '01d'}.png'),
              ),
              // AssetImage(getWeatherIcon(_weather?.weatherMain))),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 60, top: 120),
              child: Text(
                weatherDataCurrent?.current.weather![0].main ?? 'Rainy',
                style: const TextStyle(
                  fontSize: 22,
                  fontFamily: 'Digital',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 0, left: 160),
              child: Text(
                '°',
                style: TextStyle(
                  fontSize: 110,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 60,
              width: 60,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.cyan, borderRadius: BorderRadius.circular(15)),
              child: Image.asset("assets/cloud.png"),
            ),
            Container(
              height: 60,
              width: 60,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.cyan, borderRadius: BorderRadius.circular(15)),
              child: Image.asset("assets/humidity.png"),
            ),
            Container(
              height: 60,
              width: 60,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.cyan, borderRadius: BorderRadius.circular(15)),
              child: Image.asset("assets/windspeed.png"),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          SizedBox(
            height: 20,
            width: 60,
            child: Text(
              "${weatherDataCurrent?.current.clouds ?? '0'}%",
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 20,
            width: 60,
            child: Text(
              "${weatherDataCurrent?.current.humidity ?? '0'}%",
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 20,
            width: 60,
            child: Text(
              "${weatherDataCurrent?.current.windSpeed ?? '0'}m/s",
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          )
        ]),
        // Container(
        //   child: const Row(
        //     children: [LineChartSample2()],
        //   ),
        // )
      ],
    );
  }
}
