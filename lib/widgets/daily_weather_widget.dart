import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/weather_data_daily.dart';
import 'package:weather_app/pages/detail_page.dart';

class DailyWeatherWidget extends StatelessWidget {
  final WeatherDataDaily? weatherDataDaily;
  const DailyWeatherWidget({super.key, this.weatherDataDaily});
  String getDate(final timeStamp) {
    final time1 = timeStamp ?? 0;
    final time = DateTime.fromMillisecondsSinceEpoch(time1 * 1000);
    String date = DateFormat.E().format(time);
    return date;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 35),
                  child: Text(
                    '7-Day Forecasts',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 150,
              child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(left: 22, right: 22),
                  itemCount: weatherDataDaily?.daily.length,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        if (index != 0) {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => DetailPage(
                                        weatherDataDaily: weatherDataDaily,
                                        index: index,
                                      )));
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        margin: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 10, top: 10),
                        width: 70,
                        decoration: BoxDecoration(
                            color: index == 0 ? Colors.blue : Colors.cyan,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(24)),
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(0, 1),
                                blurRadius: 5,
                                color: Colors.black45,
                              )
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(getDate(weatherDataDaily?.daily[index].dt)),
                            Image.network(
                              'https://openweathermap.org/img/wn/${weatherDataDaily?.daily[index].weather![0].icon ?? '01d'}@2x.png',
                            ),
                            Text(
                              '${weatherDataDaily?.daily[index].temp!.max ?? 0}°',
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                                '${weatherDataDaily?.daily[index].temp!.min ?? 0}°'),
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        )
      ],
    );
  }
}
