import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/weather_data_hourly.dart';
import 'package:fl_chart/fl_chart.dart';

class HourlyWeatherWidget extends StatefulWidget {
  final WeatherDataHourly? weatherDataHourly;

  const HourlyWeatherWidget({super.key, this.weatherDataHourly});
  @override
  State<HourlyWeatherWidget> createState() => _HourlyWeatherWidget();
}

class _HourlyWeatherWidget extends State<HourlyWeatherWidget> {
  String getTime(final timeStamp) {
    final timeStamp1 = timeStamp ?? 0;
    final time = DateTime.fromMillisecondsSinceEpoch(timeStamp1 * 1000);
    String dateTime = DateFormat('Hm').format(time);
    return dateTime;
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta, double chartWidth) {
    final style = TextStyle(
      fontWeight: FontWeight.bold,
      fontFamily: 'Digital',
      fontSize: 18 * chartWidth / 500,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = getTime(widget.weatherDataHourly?.hourly[0].dt);
        break;
      case 1:
        text = getTime(widget.weatherDataHourly?.hourly[2].dt);
        break;
      case 2:
        text = getTime(widget.weatherDataHourly?.hourly[4].dt);
        break;
      case 3:
        text = getTime(widget.weatherDataHourly?.hourly[6].dt);
        break;
      case 4:
        text = getTime(widget.weatherDataHourly?.hourly[8].dt);
        break;
      case 5:
        text = getTime(widget.weatherDataHourly?.hourly[10].dt);
        break;
      case 6:
        text = getTime(widget.weatherDataHourly?.hourly[12].dt);
        break;

      default:
        return Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: style),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<int> showingTooltipOnSpots = [0, 1, 2, 3, 4, 5, 6];
    List<FlSpot> chartData = [
      FlSpot(0, widget.weatherDataHourly?.hourly[0].temp!.toDouble() ?? 0),
      FlSpot(1, widget.weatherDataHourly?.hourly[2].temp!.toDouble() ?? 0),
      FlSpot(2, widget.weatherDataHourly?.hourly[4].temp!.toDouble() ?? 0),
      FlSpot(3, widget.weatherDataHourly?.hourly[6].temp!.toDouble() ?? 0),
      FlSpot(4, widget.weatherDataHourly?.hourly[8].temp!.toDouble() ?? 0),
      FlSpot(5, widget.weatherDataHourly?.hourly[10].temp!.toDouble() ?? 0),
      FlSpot(6, widget.weatherDataHourly?.hourly[12].temp!.toDouble() ?? 0),
    ];
    // print(widget.weatherDataHourly?.hourly[1].dt);
    // print(widget.weatherDataHourly?.hourly[2].dt);
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
        padding: const EdgeInsets.only(left: 40, right: 40),
        width: double.infinity,
        height: 80,
        child: LineChart(
          LineChartData(
              showingTooltipIndicators: showingTooltipOnSpots.map((index) {
                return ShowingTooltipIndicators([
                  LineBarSpot(LineChartBarData(color: Colors.black), index,
                      chartData[index]),
                ]);
              }).toList(),
              titlesData: FlTitlesData(
                leftTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1,
                    getTitlesWidget: (value, meta) =>
                        bottomTitleWidgets(value, meta, 350),
                  ),
                ),
              ),
              borderData: FlBorderData(show: false),
              gridData: const FlGridData(show: false),
              lineTouchData: const LineTouchData(
                  enabled: false,
                  touchTooltipData: LineTouchTooltipData(
                      tooltipBgColor: Colors.transparent,
                      tooltipPadding: EdgeInsets.only(bottom: -4))),
              lineBarsData: [
                LineChartBarData(
                    spots: chartData, shadow: const Shadow(blurRadius: 10))
              ]),
        ),
      ),
    ]);
  }
}
