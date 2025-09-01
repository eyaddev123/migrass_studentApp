import 'package:flutter/material.dart';
import 'package:student/core/resource/colors_manager.dart';
import 'package:student/core/resource/icon_image_manager.dart';
import 'package:student/feature/ui/Screenes/Home_Screen/HomeScreen/home_screen.dart';
import 'package:student/feature/ui/Screenes/Home_Screen/Program_Screen/my_program.dart';
import 'package:student/feature/ui/Screenes/Home_Screen/Recorder_Screen/record_screen/recorder_screen.dart';


class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}
class _NavigationScreenState extends State<NavigationScreen> {
  int currentIndex = 0;
  List<Widget> screens = [
    HomeScrren(),
    myProgram(),
    RecordingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        backgroundColor: ColorManager.white,
        selectedItemColor: ColorManager.accentGreen,
        unselectedItemColor: ColorManager.gray,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              IconImageManager.home,
              color: currentIndex == 0
                  ? ColorManager.accentGreen
                  : ColorManager.gray,
            ),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              IconImageManager.report,
              color: currentIndex == 1
                  ? ColorManager.accentGreen
                  : ColorManager.gray,
            ),
            label: 'برنامج',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              IconImageManager.Microphone,
              color: currentIndex == 2
                  ? ColorManager.accentGreen
                  : ColorManager.gray,
            ),
            label: 'تسجيلات',
          ),
        ],
      ),
    );
  }
}
