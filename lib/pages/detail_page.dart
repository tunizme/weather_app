import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_data_daily.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatefulWidget {
  final WeatherDataDaily? weatherDataDaily;
  final int? index;
  const DetailPage({super.key, this.weatherDataDaily, this.index});
  @override
  State<DetailPage> createState() => _DetailPage();
}

class _DetailPage extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Shader linearGradient = const LinearGradient(
      colors: <Color>[Color.fromARGB(255, 175, 215, 255), Color(0xff9AC6F3)],
    ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

    String getDateMMMEd(final timeStamp) {
      final checkTime = timeStamp ?? 0;
      final dateTime = DateTime.fromMillisecondsSinceEpoch(checkTime * 1000);
      String date = DateFormat.MMMEd().format(dateTime);
      return date;
    }

    String capitalize(final s) => s[0].toUpperCase() + s.substring(1);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,

        elevation: 0.0,
        title: Text(
            getDateMMMEd(widget.weatherDataDaily?.daily[widget.index!].dt)),
        //Replace
        leading: IconButton(
          padding: const EdgeInsets.only(left: 20.0),
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // Positioned(
          //   top: 10,
          //   left: 10,
          //   width: 500,
          //   child: SizedBox(
          //     height: 150,
          //     child: ListView.builder(
          //         shrinkWrap: true,
          //         padding: const EdgeInsets.only(left: 22, right: 22),
          //         itemCount: widget.weatherDataDaily?.daily.length,
          //         scrollDirection: Axis.horizontal,
          //         // physics: const BouncingScrollPhysics(),
          //         itemBuilder: (BuildContext context, int index) {
          //           return GestureDetector(
          //             onTap: () {
          //               if (index != widget.index) {
          //                 Navigator.push(
          //                     context,
          //                     PageRouteBuilder(
          //                       pageBuilder: (_, __, ___) => DetailPage(
          //                         weatherDataDaily: widget.weatherDataDaily,
          //                         index: index,
          //                       ),
          //                       transitionDuration:
          //                           const Duration(milliseconds: 200),
          //                       transitionsBuilder: (_, a, __, c) =>
          //                           FadeTransition(opacity: a, child: c),
          //                     ));
          //               }
          //             },
          //             child: index != 0
          //                 ? Container(
          //                     padding: const EdgeInsets.symmetric(
          //                         horizontal: 10, vertical: 10),
          //                     margin: const EdgeInsets.only(
          //                         left: 10, right: 10, bottom: 10, top: 10),
          //                     width: 70,
          //                     decoration: BoxDecoration(
          //                         color: index == widget.index
          //                             ? Colors.blue
          //                             : Colors.cyan,
          //                         borderRadius: const BorderRadius.all(
          //                             Radius.circular(24)),
          //                         boxShadow: const [
          //                           BoxShadow(
          //                             offset: Offset(0, 1),
          //                             blurRadius: 5,
          //                             color: Colors.black45,
          //                           )
          //                         ]),
          //                     child: Column(
          //                       mainAxisAlignment:
          //                           MainAxisAlignment.spaceBetween,
          //                       children: [
          //                         Text(getDateE(widget
          //                                 .weatherDataDaily?.daily[index].dt ??
          //                             '0')),
          //                         Image.network(
          //                           'https://openweathermap.org/img/wn/${widget.weatherDataDaily?.daily[index].weather![0].icon ?? '01d'}@2x.png',
          //                         ),
          //                         Text(
          //                           '${widget.weatherDataDaily?.daily[index].temp!.max ?? 0}°',
          //                           style: const TextStyle(color: Colors.white),
          //                         ),
          //                         Text(
          //                             '${widget.weatherDataDaily?.daily[index].temp!.min ?? 0}°'),
          //                       ],
          //                     ),
          //                   )
          //                 : Container(),
          //           );
          //         }),
          //   ),
          // ),
          Positioned(
            top: 70,
            left: 0,
            child: Container(
                height: size.height * 0.6,
                width: size.width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      topLeft: Radius.circular(50),
                    )),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                        top: -55,
                        right: 20,
                        left: 20,
                        child: Container(
                          width: size.width * 0.7,
                          height: 300,
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.center,
                                  colors: [
                                    Color(0xffa9c1f5),
                                    Color(0xff6696f5),
                                  ]),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.withOpacity(.1),
                                  offset: const Offset(0, 25),
                                  blurRadius: 3,
                                  spreadRadius: -10,
                                ),
                              ]),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                top: -20,
                                left: 20,
                                child: Image.asset(
                                  'assets/${widget.weatherDataDaily?.daily[widget.index!].weather![0].icon}.png',
                                  //replace
                                  width: 150,
                                ),
                              ),
                              Positioned(
                                top: 110,
                                left: 50,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    capitalize(widget
                                        .weatherDataDaily
                                        ?.daily[widget.index!]
                                        .weather![0]
                                        .description
                                        .toString()),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                left: -20,
                                child: Container(
                                    width: size.width,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              children: [
                                                const Text(
                                                  'Cloud',
                                                  //replace
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        137, 57, 45, 45),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Container(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  height: 70,
                                                  width: 70,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Color(0xffE0E8FB),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                15)),
                                                  ),
                                                  child: Image.asset(
                                                      'assets/cloud.png'),
                                                  //replace
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Text(
                                                  '${widget.weatherDataDaily?.daily[widget.index!].clouds}%',
                                                  //Replace
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                const Text(
                                                  'Humidity',
                                                  //replace
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Container(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  height: 70,
                                                  width: 70,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Color(0xffE0E8FB),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                15)),
                                                  ),
                                                  child: Image.asset(
                                                      'assets/humidity.png'),
                                                  //replace
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Text(
                                                  '${widget.weatherDataDaily?.daily[widget.index!].humidity}%',
                                                  //Replace
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                const Text(
                                                  'Windspeed',
                                                  //replace
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Container(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  height: 70,
                                                  width: 70,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Color(0xffE0E8FB),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                15)),
                                                  ),
                                                  child: Image.asset(
                                                      'assets/windspeed.png'),
                                                  //replace
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Text(
                                                  '${widget.weatherDataDaily?.daily[widget.index!].windSpeed}m/s',
                                                  //Replace
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        // Row(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.spaceEvenly,
                                        //   children: [
                                        //     Column(
                                        //       children: [
                                        //         const Text(
                                        //           'Rainy',
                                        //           //replace
                                        //           style: TextStyle(
                                        //             color: Colors.black54,
                                        //           ),
                                        //         ),
                                        //         const SizedBox(
                                        //           height: 8,
                                        //         ),
                                        //         Container(
                                        //           padding: const EdgeInsets.all(
                                        //               10.0),
                                        //           height: 70,
                                        //           width: 70,
                                        //           decoration:
                                        //               const BoxDecoration(
                                        //             color: Color(0xffE0E8FB),
                                        //             borderRadius:
                                        //                 BorderRadius.all(
                                        //                     Radius.circular(
                                        //                         15)),
                                        //           ),
                                        //           child: Image.asset(
                                        //               'assets/rainy.png'),
                                        //           //replace
                                        //         ),
                                        //         const SizedBox(
                                        //           height: 8,
                                        //         ),
                                        //         Text(
                                        //           '${widget.weatherDataDaily?.daily[widget.index!].rain}mm/h',
                                        //           //Replace
                                        //           style: const TextStyle(
                                        //             fontWeight: FontWeight.bold,
                                        //           ),
                                        //         )
                                        //       ],
                                        //     ),
                                        //     Column(
                                        //       children: [
                                        //         const Text(
                                        //           'Sunrise',
                                        //           //replace
                                        //           style: TextStyle(
                                        //             color: Color.fromARGB(
                                        //                 137, 57, 45, 45),
                                        //           ),
                                        //         ),
                                        //         const SizedBox(
                                        //           height: 8,
                                        //         ),
                                        //         Container(
                                        //           padding: const EdgeInsets.all(
                                        //               10.0),
                                        //           height: 70,
                                        //           width: 70,
                                        //           decoration:
                                        //               const BoxDecoration(
                                        //             color: Color(0xffE0E8FB),
                                        //             borderRadius:
                                        //                 BorderRadius.all(
                                        //                     Radius.circular(
                                        //                         15)),
                                        //           ),
                                        //           child: Image.asset(
                                        //               'assets/sunrise.png'),
                                        //           //replace
                                        //         ),
                                        //         const SizedBox(
                                        //           height: 8,
                                        //         ),
                                        //         Text(
                                        //           getTime(widget
                                        //               .weatherDataDaily
                                        //               ?.daily[widget.index!]
                                        //               .sunrise),
                                        //           //Replace
                                        //           style: const TextStyle(
                                        //             fontWeight: FontWeight.bold,
                                        //           ),
                                        //         )
                                        //       ],
                                        //     ),
                                        //     Column(
                                        //       children: [
                                        //         const Text(
                                        //           'Sunset',
                                        //           //replace
                                        //           style: TextStyle(
                                        //             color: Colors.black54,
                                        //           ),
                                        //         ),
                                        //         const SizedBox(
                                        //           height: 8,
                                        //         ),
                                        //         Container(
                                        //           padding: const EdgeInsets.all(
                                        //               10.0),
                                        //           height: 70,
                                        //           width: 70,
                                        //           decoration:
                                        //               const BoxDecoration(
                                        //             color: Color(0xffE0E8FB),
                                        //             borderRadius:
                                        //                 BorderRadius.all(
                                        //                     Radius.circular(
                                        //                         15)),
                                        //           ),
                                        //           child: Image.asset(
                                        //               'assets/sunset.png'),
                                        //           //replace
                                        //         ),
                                        //         const SizedBox(
                                        //           height: 8,
                                        //         ),
                                        //         Text(
                                        //           getTime(widget
                                        //               .weatherDataDaily
                                        //               ?.daily[widget.index!]
                                        //               .sunset),
                                        //           //Replace
                                        //           style: const TextStyle(
                                        //             fontWeight: FontWeight.bold,
                                        //           ),
                                        //         )
                                        //       ],
                                        //     ),
                                        //   ],
                                        // )
                                      ],
                                    )),
                              ),
                              Positioned(
                                top: 20,
                                right: 20,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${widget.weatherDataDaily?.daily[widget.index!].temp?.day}',
                                      style: TextStyle(
                                        fontSize: 80,
                                        fontWeight: FontWeight.bold,
                                        foreground: Paint()
                                          ..shader = linearGradient,
                                      ),
                                    ),
                                    Text(
                                      'o',
                                      style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                        foreground: Paint()
                                          ..shader = linearGradient,
                                      ),
                                    ),
                                    Text(
                                      'C',
                                      style: TextStyle(
                                        fontSize: 60,
                                        fontWeight: FontWeight.bold,
                                        foreground: Paint()
                                          ..shader = linearGradient,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                    Positioned(
                        top: 280,
                        left: 20,
                        child: SizedBox(
                          height: 240,
                          width: size.width * .9,
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: widget.weatherDataDaily?.daily.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  margin: const EdgeInsets.only(
                                      left: 10, top: 10, right: 10, bottom: 5),
                                  height: 80,
                                  width: size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              Colors.cyanAccent.withOpacity(.1),
                                          spreadRadius: 5,
                                          blurRadius: 20,
                                          offset: const Offset(0, 3),
                                        ),
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          getDateMMMEd(widget.weatherDataDaily
                                              ?.daily[index].dt),
                                          style: const TextStyle(
                                            color: Color(0xff6696f5),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '${widget.weatherDataDaily?.daily[index].temp!.max ?? 0}°',
                                              style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 30,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const Text(
                                              '/',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 30,
                                              ),
                                            ),
                                            Text(
                                              '${widget.weatherDataDaily?.daily[index].temp!.min ?? 0}°',
                                              style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 25,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.network(
                                                'https://openweathermap.org/img/wn/${widget.weatherDataDaily?.daily[index].weather![0].icon ?? '01d'}@2x.png',
                                                width: 30),
                                            Text(
                                                '${widget.weatherDataDaily?.daily[index].weather![0].description}'),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ))
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
