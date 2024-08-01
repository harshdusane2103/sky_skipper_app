import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sky_skipper_app/View/Home.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3),(){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomeScreen()));
    });
    return Scaffold(
      body: Center(
        child: Container(
          height: 300,
          width: 300,
          decoration:BoxDecoration(
          // color: Colors.red,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/image/logo.png'),
            )
          ),
        ),
      ),
    );
  }
}
