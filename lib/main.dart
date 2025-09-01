import 'package:flutter/material.dart';
import 'package:student/feature/ui/Screenes/DrawerScreen/drawer_screen.dart';
import 'package:student/feature/ui/Screenes/Login/SplashUi.dart';
import 'package:student/feature/ui/Screenes/MyExam_Screen/MyExamScreen.dart';
import 'package:student/feature/ui/Screenes/MyMarks_Screen/MyMarksScreen.dart';
import 'package:student/feature/ui/Screenes/achivment_screen/my_achivment.dart';
import 'package:student/feature/ui/Screenes/lessons_screen/my_lesson.dart';
import 'feature/ui/Screenes/Home_Screen/NavigationScreen.dart';
import 'feature/ui/Screenes/Home_Screen/HomeScreen/home_screen.dart';
import 'feature/ui/Screenes/Home_Screen/Recorder_Screen/record_screen/recorder_screen.dart';
import 'feature/ui/Screenes/login/loginUI.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home://CustomDrawer(),
      //loginScreen(),
     // HomeScrren(),
      //NavigationScreen(),
      //Myexamscreen(),
     // Mymarksscreen(),
     // RecordingScreen(),
     // NavigationScreen(),
     // myachivment(),
      //  MyLesson(),
     SplashScreen(),
      //ChallangeScreen(),
    );
  }
}