import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NavigationHelper {
  static void navigateTo(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }
}



void openWebApp() async {
 // const url = 'http://192.168.1.108:4000';
  const url = 'http://192.168.1.108:52169/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    print('لا يمكن فتح الرابط $url');
  }
}
