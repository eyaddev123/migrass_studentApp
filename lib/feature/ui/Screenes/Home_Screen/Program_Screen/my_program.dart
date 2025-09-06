import 'package:flutter/material.dart';
import 'package:student/core/resource/colors_manager.dart';

class myProgram extends StatelessWidget {
  const myProgram({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  ColorManager.successBackgroundLight,
        body: SafeArea(
            child: Text("My Program")));
  }
}

