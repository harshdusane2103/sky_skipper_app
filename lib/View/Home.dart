import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sky_skipper_app/Modal/Modal.dart';
import 'package:sky_skipper_app/Provider/provider.dart';
import 'package:sky_skipper_app/View/detail.dart';

TextEditingController txtsearch = TextEditingController();

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeProvider homeProvidertrue =
        Provider.of<HomeProvider>(context, listen: true);
    HomeProvider homeProviderfalse =
        Provider.of<HomeProvider>(context, listen: false);
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: homeProviderfalse.fromMap(homeProvidertrue.search),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              WeatherModal? weather = snapshot.data;

              return Container(
                height: h,
                width: w,
                decoration: BoxDecoration(
                    color: Colors.teal.shade100,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          weather?.currentModal.is_day == 1 ? Day : Nigth),
                    )),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 100,
                        width: w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              child: TextField(
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                controller: txtsearch,
                                onSubmitted: (value) {
                                  homeProviderfalse.Searchweather(
                                      txtsearch.text);
                                },
                                decoration: InputDecoration(
                                  suffixIcon: Icon(
                                    Icons.search,
                                    color: Colors.white,
                                  ),
                                  prefix: Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.white,
                                  ),
                                  hintText: ('Search City'),
                                  hintStyle: TextStyle(color: Colors.white),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 3)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            InkWell(
                                onTap: () {
                                  homeProviderfalse.addFavCity(
                                    weather!.locationModal.name,
                                    weather.currentModal.temp_c.toString(),
                                    weather.currentModal.condition.text,
                                  );
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => DetailScreen()));
                                },
                                child: Icon(
                                  Icons.favorite_border,
                                  color: Colors.white,
                                )),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        weather!.locationModal.name,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 32),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${weather.currentModal.temp_c.toString()}' + '°C',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 60),
                      ),
                      Text(
                        '${weather.currentModal.condition.text}',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Card(
                          color: Colors.white12,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                title: Text(
                                  '${weather!.locationModal.name}, ${weather!.locationModal.region},',
                                  style: TextStyle(color: Colors.white),
                                ),
                                subtitle: Text(
                                  '${weather?.locationModal.country} | ${weather?.locationModal.localtime}',
                                  style:
                                      TextStyle(height: 3, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Card(
                          color: Colors.white12,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                title: Text(
                                  'Current Weather',
                                  style: TextStyle(color: Colors.white),
                                ),
                                subtitle: Text(
                                  '${weather.locationModal.country}',
                                  style: TextStyle(color: Colors.white),
                                ),
                                trailing: Image.network(
                                  'https:${weather.currentModal.condition.icon}',
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Text('Temp',
                                            style:
                                                TextStyle(color: Colors.white)),
                                        Text(
                                            '${weather.currentModal.temp_c} °C',
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text('Feels Like',
                                            style:
                                                TextStyle(color: Colors.white)),
                                        Text(
                                            '${weather.currentModal.temp_f} °C',
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text('Humidity',
                                            style:
                                                TextStyle(color: Colors.white)),
                                        Text(
                                            '${weather.currentModal.humidity} %',
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        height: 180,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white12,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.watch_later,
                                    size: 20,
                                    color: Colors.white70,
                                  ),
                                  Text(
                                    ' 24 - Hour Forecast',
                                    style: TextStyle(
                                        color: Colors.white70, fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  ...List.generate(
                                      weather.forecastModal.forecastDay.first
                                          .hour.length, (index) {
                                    final hour = weather.forecastModal
                                        .forecastDay.first.hour[index];
                                    return Container(
                                        height: 120,
                                        width: 80,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${hour.time.split(" ").sublist(1, 2).join(" ")}',
                                              style: TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 18),
                                            ),
                                            Image.network(
                                                'https:${hour.hourConditionModal.icon}'),
                                            Text(
                                              '${hour.temp_c}',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            ),
                                          ],
                                        ));
                                  })
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.all(10),
                            height: 180,
                            width: 180,
                            decoration: BoxDecoration(
                                color: Colors.white12,
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Wind Speed',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 28,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  '${weather.currentModal.wind_kph}' + 'Kph',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 22),
                                ),
                                Text(
                                  '${weather.currentModal.wind_mph}' + 'mph',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 22),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            height: 180,
                            width: 170,
                            decoration: BoxDecoration(
                                color: Colors.white12,
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              children: [
                                Text(
                                  'Humidity',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 28),
                                ),
                                Text(
                                  '${weather.currentModal.humidity}' + '%',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 36),
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.hasError.toString()));
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

String Day =
    "https://img.freepik.com/free-photo/beautiful-sunset-lake-filtered-image-processed-vintage_1232-2166.jpg?ga=GA1.2.19654575.1717952195&semt=ais_hybrid";
String Nigth =
    "https://img.freepik.com/free-photo/starry-sky-town_23-2151642692.jpg?ga=GA1.2.19654575.1717952195&semt=ais_hybrid";
int selectedIndex = 0;
