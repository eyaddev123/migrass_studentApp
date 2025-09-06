import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class FirebaseNotifications {
  final firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await firebaseMessaging.requestPermission();
    if (!kReleaseMode) {
      var token = await firebaseMessaging.getToken();
      print("FCM :$token");
    }
    handleForegroundNotification();
    handleBackgroundNotification();
  }

  void handleMessage(RemoteMessage? message, BuildContext context) {
    if (message == null) return;
  }

  Future<void> handleBackgroundNotification() async {
    FirebaseMessaging.instance.getInitialMessage().then((message) {});

    FirebaseMessaging.onMessageOpenedApp.listen((message) {});
  }

  void handleForegroundNotification() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showNotification(message.notification!.title, message.notification!.body);
    });
  }

  void showNotification(String? title, String? body) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails details =
    NotificationDetails(android: androidDetails);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      details,
    );
  }


}
