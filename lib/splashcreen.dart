import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application/screens/auth_page.dart';
import 'package:flutter_application/screens/home_screen.dart';
import 'package:flutter_application/screens/btm_bar.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget{

  _SplashScreen createState() => _SplashScreen();

}

class _SplashScreen extends State<SplashScreen>{

  void initState(){
    super.initState();
    splashscreenStart();
  }

  splashscreenStart() async{
    var duration = const Duration(seconds: 3);
    return Timer(duration, (){
      Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => LoginPage()),
        
      );
    });
  }
  @override
  Widget build(BuildContext context){

  return Scaffold(
    backgroundColor: Colors.white,
    body: Stack(
        children: [ 
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/logo_bestland.png', // Replace with your logo image path
                width: 200.0, // Set the width and height of your logo
                height: 200.0,
              ),
            ),
          ),
        ],
      ),
  );
  }

}