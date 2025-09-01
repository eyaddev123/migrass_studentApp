import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student/core/function/function.dart';
import 'package:student/core/resource/colors_manager.dart';
import 'package:student/core/resource/icon_image_manager.dart';
import 'package:student/core/widgets/green_container.dart';
import 'package:student/feature/ui/Screenes/Login/LoginUi.dart';
import 'package:student/feature/ui/Screenes/MyExam_Screen/MyExamScreen.dart';
import 'package:student/feature/ui/Screenes/MyMarks_Screen/MyMarksScreen.dart';

class CustomDrawer extends StatelessWidget {
  final int circleId;
  const CustomDrawer({super.key, required this.circleId});

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('token');
    await prefs.clear();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const loginScreen()),
          (route) => false,
    );
  }

  Future<void> showLogoutConfirmation(BuildContext context) async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text(
          "هل أنت متأكد أنك تريد تسجيل الخروج؟",
          textAlign: TextAlign.center,
        ),
        actions: [
          defauilButton(
            background: ColorManager.lightGray,
            textcolorbutton: ColorManager.black,
            function: () => Navigator.pop(context, false),
            text: "لا",
          ),
          defauilButton(
            background: ColorManager.lightGray,
            textcolorbutton: ColorManager.black,
            function: () => Navigator.pop(context, true),
            text: "نعم",
          ),
        ],
      ),
    );

    if (shouldLogout == true) {
      logout(context);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.5),
      body: SafeArea(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.75,
            decoration: BoxDecoration(
              color:ColorManager.white,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(2, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: ColorManager.lightGray,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: ColorManager.black,
                        size: 24,
                      ),
                    ),
                  ),
                ),

                _buildDrawerItem(
                  title: "علاماتي",
                  icon: Image.asset(IconImageManager.blueNewspaper,
                      width: 30, height: 30,
                    color: ColorManager.successLight, ),
                  onTap: ()
                  {
                    NavigationHelper.navigateTo(context,  Mymarksscreen(circleId: circleId),);
                  },
                ),
                _buildDrawerItem(
                  title: "برنامجي",
                  icon:  Image.asset(IconImageManager.myprogram,
                      width: 30, height: 30,
                    color: ColorManager.successLight,),
                  onTap: ()
                  {
                    NavigationHelper.navigateTo(context, const Myexamscreen());
                  },
                ),
                _buildDrawerItem(
                  title: "شارك التطبيق",
                  icon:  Image.asset(IconImageManager.shareImg,
                      width: 30, height: 30,
                    color:ColorManager.successLight,
                  ),
                  onTap: () {},
                ),

                const Spacer(),

                Padding(
                  padding: const EdgeInsets.only(bottom: 60.0,right: 35.0),
                  child: InkWell(
                    onTap: () => showLogoutConfirmation(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          "تسجيل خروج",
                          style: TextStyle(
                            fontSize: 18,
                            color: ColorManager.gray,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Container(
                          width: 1.5,
                          height: 20,
                          color: Colors.grey,
                        ),
                      //  const SizedBox(width: 2),
                        const Icon(
                          Icons.arrow_forward,
                          color: ColorManager.gray,
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required String title,
    required Widget icon,
    required VoidCallback onTap,
  }) =>
      Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Column(
          children: [
            ListTile(
              leading: IconTheme(
                data: const IconThemeData(
                  color: ColorManager.successLight,
               //   size: 28,
                ),
                child: icon,
              ),
              title: Text(
                title,
                style: const TextStyle(
                  fontSize: 23,
                  color:ColorManager.successLight,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: onTap,
            ),
            const Divider(height: 1),
          ],
        ),
      );

  }
