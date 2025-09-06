import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:student/core/resource/image_manager.dart';
import 'package:student/feature/ui/Screenes/Home_Screen/NavigationScreen.dart';
import 'package:student/feature/ui/Screenes/login/loginUI.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _navigateAfterSplash();
  }
  Future<void> _navigateAfterSplash() async {
    Timer(const Duration(seconds: 5), () async {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final codeUser = prefs.getString('code_user');
      final mosqueCode = prefs.getString('mosque_code');

      Widget nextScreen;

      if (token != null && codeUser != null && mosqueCode != null) {
        nextScreen = const NavigationScreen();
      } else {
        nextScreen = const loginScreen();
      }

      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 800),
          pageBuilder: (_, __, ___) => nextScreen,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
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

