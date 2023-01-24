import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uber_clone/auth/login.dart';
import 'package:uber_clone/user/bottombar.dart';

import '../user/home.dart';


class SplashServices{

  void isLogin(BuildContext context){
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null){
      Timer(Duration(seconds: 3), () =>  Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => BottomBar())) );

    }
    else{
      Timer(Duration(seconds: 3), () =>  Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => LoginScreen())) );

          }


  }
}