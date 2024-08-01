import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sky_skipper_app/Modal/Modal.dart';
import 'package:sky_skipper_app/Provider/provider.dart';

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
      // appBar: AppBar(
      //
      //   // backgroundColor: homeProvidertrue.weatherModal?.current.isDay==1?Primary:secondaray,
      //   centerTitle: true,
      //   title:TextField(
      //
      //                             controller: txtsearch,
      //                             onSubmitted: (value) {
      //                               homeProviderfalse.Searchweather(txtsearch.text);
      //                             },
      //
      //                             decoration: InputDecoration(
      //                               focusedBorder: OutlineInputBorder(
      //                                   borderSide:
      //                                   BorderSide(color: Colors.purple)),
      //                               enabledBorder: OutlineInputBorder(
      //                                   borderSide:
      //                                   BorderSide(color: Colors.white)),
      //                             ),
      //
      //
      //                           ),
      //
      //   actions: [InkWell(onTap: () {}, child: Icon(Icons.add))],
      // ),
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
                              controller: txtsearch,
                              onSubmitted: (value) {
                                homeProviderfalse.Searchweather(txtsearch.text);
                              },
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.purple)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Icon(
                            Icons.more_vert,
                            color: Colors.white,
                          ),
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
                          fontSize: 30),
                    ),
                    Text(
                      '${weather.currentModal.temp_c.toString()}' + '°C',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 54),
                    ),
                    Text(
                      '${weather.currentModal.condition.text}',
                      style: TextStyle(color: Colors.white),
                    ),
                    Container(
                      height: h * 0.50,
                      width: w * 0.90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      color: Colors.black12,
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('24-hour forcast',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                              Row(
                                children: [
                                  ...List.generate(
                                      weather.forecastModal.forecastDay.first.hour
                                          .length, (index) {
                                    final hour = weather
                                        .forecastModal.forecastDay.first.hour[index];
                                    return Row(
                                      children: [
                                        Text('${weather.forecastModal.forecastDay.first.hour.first.temp_c}'+'°C'+' ',style: TextStyle(color: Colors.white,fontSize: 20),),
                                        Container(height: 40,width: 40,decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(weather.currentModal.condition.icon))),)
                                      ],
        
                                    );
                                  }),
                                ],
                              ),
        
                          // Text('${weather.currentModal.condition.icon}'+ '',style: TextStyle(color: Colors.white,fontSize: 20),),
                          // Text(
                          //   '${hour.time.split(" ").sublist(1,2).join(" ")}',
                          //   style:
                          //   TextStyle(color: Colors.white70,fontSize: 18),
                          // ),
                          // Image.network(
                          //     'https:${hour.hourConditionModal.icon}'),
                          // Text(
                          //   '${hour.temp_c}',
                          //   style:
                          //   TextStyle(color: Colors.white,fontSize: 18),
                          //
                          //   ],
                          // ),
                          ],
                        ),
                      ),
                    ),
                    )
                  ],
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

//   Expanded(
//   child: ListView.builder(
//       shrinkWrap: true
//       itemBuilder: (context, index) => InkWell(
//         onTap: () {
//           selectedIndex=index;
//           // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PixbayDetailScreen()));
//         },
//         child: Container(
//           margin: EdgeInsets.all(10),
//           height: 200,
//           width: 360,
//       //     decoration: BoxDecoration(
//       //       borderRadius: BorderRadius.circular(10),
//       //       image: DecorationImage(
//       //         image:
//       //         // NetworkImage(
//       //           //  '${search.hits[index].webformatURL}'),),),
//       //   ),
//       // )),
// );
