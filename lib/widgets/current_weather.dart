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
                    'assets/images/${weatherDataCurrent?.current.weather![0].icon ?? '01d'}.png'),
              ),
              // AssetImage(getWeatherIcon(_weather?.weatherMain))),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 48, top: 120),
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 68,
              width: 68,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 177, 213, 247),
                  borderRadius: BorderRadius.circular(15)),
              child: Image.asset("assets/images/cloud.png"),
            ),
            Container(
              height: 68,
              width: 68,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 177, 213, 247),
                  borderRadius: BorderRadius.circular(15)),
              child: Image.asset("assets/images/humidity.png"),
            ),
            Container(
              height: 68,
              width: 68,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 177, 213, 247),
                  borderRadius: BorderRadius.circular(15)),
              child: Image.asset("assets/images/windspeed.png"),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          SizedBox(
            height: 20,
            width: 68,
            child: Text(
              "${weatherDataCurrent?.current.clouds ?? '0'}%",
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 20,
            width: 68,
            child: Text(
              "${weatherDataCurrent?.current.humidity ?? '0'}%",
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 20,
            width: 68,
            child: Text(
              "${weatherDataCurrent?.current.windSpeed ?? '0'}m/s",
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
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
