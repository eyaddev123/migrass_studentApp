
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/core/resource/colors_manager.dart';
import 'package:student/core/resource/icon_image_manager.dart';
import 'package:student/core/resource/image_manager.dart';
import 'package:student/core/widgets/Models.dart';
import 'package:student/feature/ui/Screenes/lessons_screen/bloc/lesson_States.dart';
import 'package:student/feature/ui/Screenes/lessons_screen/bloc/lesson_bloc.dart';
import 'package:student/feature/ui/Screenes/lessons_screen/bloc/lesson_eventes.dart';

class MyLesson extends StatelessWidget {
  final String lessonName;
  final int circleId;
  const MyLesson({Key? key, required this.lessonName, required this.circleId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LessonBloc(circleId)..add(LoadLessons()),
      child: Scaffold(
        backgroundColor: ColorManager.successBackgroundLight,
        body: SafeArea(
          child: Stack(
            children: [

              Positioned(
                top: 0,
                right: 0,
                child: Image.asset(
                  ImageManager().branch,
                  width: 300,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),


              Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 20),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 6, right: 60),
                                child: Text(
                                  "دروسي \n $lessonName",
                                  style: const TextStyle(
                                    color: ColorManager.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Image.asset(
                                  IconImageManager.blackBack,
                                  width: 45,
                                  height: 45,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),


                        BlocBuilder<LessonBloc, LessonState>(
                          builder: (context, state) {
                            if (state is LessonLoaded) {
                              return ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) =>
                                    buildLessonCard(state.lessons[index]),
                                separatorBuilder: (context, index) =>
                                const SizedBox(height: 40.0),
                                itemCount: state.lessons.length,
                              );
                            } else if (state is LessonLoading) {
                              return const Center(child: CircularProgressIndicator());
                            } else if (state is LessonError) {
                              return Center(child: Text(state.message));
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

