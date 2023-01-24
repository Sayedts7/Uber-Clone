import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uber_clone/user/home.dart';

import 'auth/login.dart';
import 'auth/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var lat, lang;
  Future<Position> getUserCurrentLocation() async{
    await Geolocator.requestPermission().then((value) {

    }).onError((error, stackTrace) {
      print(error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  final googleSignIn = GoogleSignIn();
  SplashServices splashservices = SplashServices();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashservices.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    // getUserCurrentLocation().then((value) {
    //   lat = value.latitude;
    //   lang = value.longitude;
    // });
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Padding(
             padding: const EdgeInsets.all(20.0),
             child: Center(child: Text('UBER' , style: TextStyle(color: Colors.white,fontSize: 100, fontWeight: FontWeight.bold),)),
           )
        ],
      ),
    );
  }
}
