import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:student/core/function/function.dart';
import 'package:student/core/resource/colors_manager.dart';
import 'package:student/core/resource/image_manager.dart';
import 'package:student/feature/ui/Screenes/achivment_screen/my_achivment.dart';
import 'package:student/feature/ui/Screenes/lessons_screen/my_lesson.dart';

class LessonHomeScreenModel {
  final String title;

  LessonHomeScreenModel({required this.title});
  factory LessonHomeScreenModel.fromJson(Map<String, dynamic> json) {
    return LessonHomeScreenModel(
      title: json['name'] ?? "",
    );
  }
}
Widget buildLessonHomeScreenCard ( BuildContext context,LessonHomeScreenModel all_Lesson, int circleId,)=>InkWell(
    onTap: () {
      print('تم الضغط!');
       NavigationHelper.navigateTo(context,  MyLesson(lessonName: all_Lesson.title,  circleId: circleId,),);
    },
    child:   Container(
     width: 140.0,
      height: 140.0,
      margin: const EdgeInsets.symmetric(vertical: 8),
     padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: ColorManager.gray,
            blurRadius: 5,
            offset: const Offset(1, 3),
          ),
       ],
      ),
      child: Column(
        children: [
          Image.asset(   ImageManager().book,
            height: 70,width: 100,),
          SizedBox(height: 10),
          Text(
           "${all_Lesson.title}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    )  );


class achivmenHomeScreenModel {
  final String title;

  achivmenHomeScreenModel ({required this.title});
}

Widget buildachivmenHomeScreenCard (BuildContext context,achivmenHomeScreenModel all_achivmen )=>InkWell(
    onTap: () {
      print('تم الضغط!');
      NavigationHelper.navigateTo(context, MyAchivment());
    },
    child:   Container(
      width: 140.0,
      height: 140.0,
      margin: const EdgeInsets.symmetric(vertical:8.0),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: ColorManager.gray,
            blurRadius: 5,
            offset: const Offset(1, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Image.asset(   ImageManager().moon,
            height: 70,width: 100,),
          SizedBox(height: 10),
          Text(
            "${all_achivmen.title}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    )  );


class LessonModel {
  final String date;
  final String description;
  final String name;

  LessonModel({ required this.date,required this.name, required this.description,});


  factory LessonModel.fromJson(Map<String, dynamic> json) {
    String rawDate = json['created_at'] ?? "";
    String formattedDate = rawDate;

    if (rawDate.isNotEmpty) {
      try {
        DateTime parsedDate = DateTime.parse(rawDate);
        formattedDate = DateFormat('dd/MM/yyyy').format(parsedDate);
      } catch (e) {

        formattedDate = rawDate;
      }
    }

    return LessonModel(
      name: json['name'] ?? "",
      description: json['description'] ?? "",
      date: formattedDate,
    );
  }
}
Widget buildLessonCard (LessonModel lessons) => Padding(
  padding: const EdgeInsets.only(
      left: 20.0,right: 20.0),
  child: Container(
    height: 100,
    decoration: BoxDecoration(
      color: ColorManager.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: ColorManager.gray,
          blurRadius: 5,
          offset: const Offset(1, 3),
        ),
      ],
    ),
    child:Row(
      children: [
        Image.asset(
          ImageManager().plant,
          width: 150,
          height: 150,
          fit: BoxFit.cover,
        ),
        //     SizedBox(width:50.0 ,),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
                top: 17.0,
                right: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  lessons.date,
                  style: const TextStyle(
                    color: ColorManager.gray,
                    fontSize: 10,
                  ),
                ),
                SizedBox(height: 10.0,),
                Text(
                  "${lessons.description}",
                  style: const TextStyle(
                    color:  ColorManager.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);

class achivmentModel {
  final String date;
  final String doneMyAchivment;

  achivmentModel({ required this.date,required this.doneMyAchivment});
}
Widget buildachivmentCard (achivmentModel   my_achivment) => Padding(
  padding: const EdgeInsets.only(
      left: 20.0,right: 20.0),
  child: Container(
    // width: 100,
    // height: 100,
    decoration: BoxDecoration(
      color: ColorManager.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: ColorManager.gray,
          blurRadius: 5,
          offset: const Offset(1, 3),
        ),
      ],
    ),
    child:Row(
      children: [
        Image.asset(
          ImageManager().plant,
          width: 150,
          height: 150,
          fit: BoxFit.cover,
        ),
        //     SizedBox(width:50.0 ,),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
                top: 17.0,
                right: 20.0,
                bottom: 17.0
            ),
            child: //Directionality(
             // textDirection: TextDirection.rtl,
           //   child:
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${ my_achivment.date}",
                    style: const TextStyle(
                      color:  ColorManager.gray,
                      //    fontWeight: FontWeight.bold,
                      fontSize: 12,),
                  ),
                  SizedBox(height: 5.0,),
                  Text(
                    " انجازي\n تم التسميع :",
                    style: const TextStyle(
                      color:  ColorManager.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,),
                  ),
                  SizedBox(height: 5.0,),
                  Text(
                    "${ my_achivment.doneMyAchivment}",
                    style: const TextStyle(
                      color:  ColorManager.gray,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
       // ),
      ],
    ),
  ),
);
