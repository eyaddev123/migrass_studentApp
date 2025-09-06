import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:student/feature/ui/Screenes/DrawerScreen/drawer_screen.dart';
import 'package:student/feature/ui/Screenes/Login/SplashUi.dart';
import 'package:student/feature/ui/Screenes/MyExam_Screen/MyExamScreen.dart';
import 'package:student/feature/ui/Screenes/MyMarks_Screen/MyMarksScreen.dart';
import 'package:student/feature/ui/Screenes/achivment_screen/my_achivment.dart';
import 'package:student/feature/ui/Screenes/lessons_screen/my_lesson.dart';
import 'core/notifications/firebase_notification.dart';
import 'firebase_options.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> setupFlutterNotifications() async {
  const AndroidInitializationSettings androidSettings =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings settings = InitializationSettings(
    android: androidSettings,
    iOS: DarwinInitializationSettings(),
  );

  await flutterLocalNotificationsPlugin.initialize(settings);
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform);

  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  FirebaseNotifications().initNotifications();
  FirebaseMessaging.onBackgroundMessage(
      _firebaseMessagingBackgroundHandler);
  await setupFlutterNotifications();




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
    //  NavigationScreen(),
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