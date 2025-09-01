import 'package:flutter/material.dart';
import 'dart:async';
import 'package:student/core/resource/image_manager.dart';
import 'package:student/feature/ui/Screenes/login/loginUI.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {

    Timer(const Duration(seconds: 5), () {

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => loginScreen()),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment:Alignment.center,
          children: [
            Image(
              image: AssetImage(ImageManager().backgraound),
               width: double.infinity,
              fit: BoxFit.cover,
            ),
            Image(
              image: AssetImage(ImageManager().logoMigrass),
              width:195,
              height:292,
            ),

          ],
        ),
      ),
    );
  }
}

