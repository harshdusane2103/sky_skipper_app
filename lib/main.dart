import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sky_skipper_app/Provider/provider.dart';
import 'package:sky_skipper_app/View/Home.dart';
import 'package:sky_skipper_app/View/Splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>HomeProvider(),
      builder: (context,child)=>
       MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}

