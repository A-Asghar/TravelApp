import 'package:flutter/material.dart';
import 'package:fyp/widgets/poppinsText.dart';
import 'package:lottie/lottie.dart';

import '../Constants.dart';
import '../models/Weather.dart';
import '../repository/WeatherRepository.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({
    Key? key,
    required this.q,
    required this.dt,
  }) : super(key: key);
  final String q;
  final String dt;
  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late final Future myFutureWeather;

  getFuture() async {
    WeatherRepository w = WeatherRepository();

    Weather weather = await w.getWeather(
        q: widget.q,
        dt: widget.dt);

    return weather;
  }

  @override
  void initState() {
    myFutureWeather = getFuture();
    // TODO: implement initState
    super.initState();
  }

  bool _isCelsius = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () => Navigator.of(context).pop()),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            Row(
              children: [
                poppinsText(text: '\u00B0F', fontBold: FontWeight.bold),
                Switch(
                  activeColor: Constants.primaryColor,
                  inactiveThumbColor: Colors.red,
                  value: _isCelsius,
                  onChanged: (value) {
                    setState(() {
                      _isCelsius = value;
                    });
                  },
                ),
                poppinsText(text: '\u00B0C', fontBold: FontWeight.bold),
                const SizedBox(width: 10)
              ],
            )
          ],
        ),
        body: FutureBuilder(
          future: myFutureWeather,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Weather weather = snapshot.data;
              Day day = snapshot.data.forecast.forecastday[0].day;
              List<Hour> hour = snapshot.data.forecast.forecastday[0].hour;
              Astro astro = snapshot.data.forecast.forecastday[0].astro;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //City Name
                  Container(
                    alignment: Alignment.center,
                    child: poppinsText(
                        text: weather.location.name,
                        size: 40.0,
                        fontBold: FontWeight.w500),
                  ),

                  // Local Time
                  poppinsText(
                      text:
                          'Local Time is ${weather.location.localtime.split(' ')[1]}'),

                  //
                  Image.network('https:${day.condition.icon}'),

                  // Day Temp
                  poppinsText(
                      text:
                          '  ${_isCelsius ? day.avgtempC.round() : day.avgtempF.round()}\u00B0',
                      size: 60.0,
                      fontBold: FontWeight.w400),

                  // Day Max Min Temp
                  Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            poppinsText(text: 'max', size: 12.0),
                            poppinsText(
                                text:
                                    '${_isCelsius ? day.maxtempC.toString() : day.maxtempF}\u00B0',
                                size: 18.0,
                                fontBold: FontWeight.w500)
                          ],
                        ),
                        customVerticalDivider(),
                        Column(
                          children: [
                            poppinsText(text: 'min', size: 12.0),
                            poppinsText(
                                text:
                                    '${_isCelsius ? day.mintempC.toString() : day.mintempF.toString()}\u00B0',
                                size: 18.0,
                                fontBold: FontWeight.w500)
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  Container(
                    margin:const EdgeInsets.symmetric(horizontal: 20),
                    height: 120,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 8,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                poppinsText(
                                    text: hour[index].time.split(' ')[1]),
                                Image.network(
                                    'https:${hour[index].condition.icon}',
                                    height: 30),
                                const SizedBox(height: 5),
                                poppinsText(
                                    text:
                                        '${_isCelsius ? hour[index].tempC.toString() : hour[index].tempF.toString()}\u00B0'),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.water_drop,
                                      size: 12,
                                    ),
                                    poppinsText(
                                        text: ' ${hour[index].chanceOfRain}%',
                                        size: 12.0),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
                  ),

                  const Divider(
                    color: Constants.secondaryColor,
                    thickness: 2,
                    indent: 10,
                    endIndent: 10,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          poppinsText(text: 'vision'),
                          poppinsText(text: '${day.avgvis_km.toString()} km')
                        ],
                      ),
                      customVerticalDivider(),
                      Column(
                        children: [
                          poppinsText(text: 'sunrise'),
                          poppinsText(text: astro.sunrise)
                        ],
                      ),
                      customVerticalDivider(),
                      Column(
                        children: [
                          poppinsText(text: 'sunset'),
                          poppinsText(text: astro.sunset)
                        ],
                      ),
                      customVerticalDivider(),
                      Column(
                        children: [
                          poppinsText(text: 'humidity'),
                          poppinsText(text: '${day.avghumidity.toString()} %')
                        ],
                      ),
                    ],
                  )
                ],
              );
            } else {
              return lottieLoader();
            }
          },
        ),
      ),
    );
  }

  Widget customVerticalDivider() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child:
          poppinsText(text: '|', size: 30.0, color: Constants.secondaryColor),
    );
  }

  Widget lottieLoader() {
    return Center(
      child: Lottie.asset('assets/lf30_editor_pdzneexn.json', height: 100),
    );
  }
}
