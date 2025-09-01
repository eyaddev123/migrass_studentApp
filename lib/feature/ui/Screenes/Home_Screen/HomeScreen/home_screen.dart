import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/core/api/dio_consumer.dart';
import 'package:student/core/function/function.dart';
import 'package:student/core/resource/colors_manager.dart';
import 'package:student/core/resource/icon_image_manager.dart';
import 'package:student/core/resource/image_manager.dart';
import 'package:student/core/widgets/Models.dart';
import 'package:student/core/widgets/green_container.dart';
import 'package:student/feature/ui/Screenes/DrawerScreen/drawer_screen.dart';
import 'package:student/feature/ui/Screenes/Home_Screen/HomeScreen/bloc_home/home_bloc.dart';
import 'package:student/feature/ui/Screenes/Home_Screen/HomeScreen/bloc_home/home_eventes.dart';
import 'package:student/feature/ui/Screenes/Home_Screen/HomeScreen/bloc_home/home_states.dart';
import 'package:student/feature/ui/Screenes/lessons_screen/my_lesson.dart';
import 'package:student/feature/ui/WebView/web_view_page.dart';

class HomeScrren extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(DioConsumer(Dio))..add(LoadHomeData()),
        child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoaded) {
                return Scaffold(
                  backgroundColor: ColorManager.successBackgroundLight,
                  drawer: CustomDrawer(circleId: state.circleId),
                  drawerScrimColor: Colors.transparent,
                  body: SafeArea(
                    child: Stack(
                      children: [

                        Positioned(
                          top: 0,
                          right: 0,
                          child: Image.asset(
                            ImageManager().branch,
                            width: 320,
                            height: 320,
                            fit: BoxFit.cover,
                          ),
                        ),


                        SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 30.0),
                            child: Column(
                              children: [
                                const SizedBox(height: 20),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Builder(
                                          builder: (context) =>
                                              IconButton(
                                                icon: Image.asset(
                                                  IconImageManager.menu,
                                                  width: 25,
                                                  height: 25,
                                                ),
                                                onPressed: () {
                                                  Scaffold
                                                      .of(context)
                                                      .openDrawer();
                                                },
                                              ),),
                                        const SizedBox(width: 7),
                                        IconButton(
                                          icon: Image.asset(
                                            IconImageManager.notifications,
                                            width: 25,
                                            height: 25,
                                          ),
                                          onPressed: () {},
                                        ),
                                      ],
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          top: 20, right: 50),
                                      child: Text(
                                        "\nأهلاً بك\n"
                                            "مؤيد بالله البابا",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: ColorManager.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 30),
                                Container(
                                  height: 150,
                                  width: 300,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        ColorManager.accentRed.withOpacity(0.8),
                                        ColorManager.accentPeach,
                                        ColorManager.accentYellow.withOpacity(
                                            0.5),
                                      ],
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: const Offset(
                                            1, 4),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        ImageManager().winner,
                                        height: 250,
                                        width: 150,
                                      ),
                                      const SizedBox(width: 50),
                                      Column(
                                        children: [
                                          const SizedBox(height: 20),
                                          Text(
                                            'تحديات',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: ColorManager.white,
                                            ),
                                          ),
                                          const SizedBox(height: 45),
                                          defauilButton(
                                            background: ColorManager.white,
                                            textcolorbutton: ColorManager
                                                .accentPeach,
                                            function: () {
                                              NavigationHelper.navigateTo(
                                                context,
                                                const WebViewPage(
                                                  url: 'http://192.168.1.108:52169/',
                                                ),
                                              );
                                            },
                                            text: 'فتح',
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 20),


                                BlocBuilder<HomeBloc, HomeState>(
                                  builder: (context, state) {
                                    if (state is HomeLoaded) {
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .end,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                right: 30.0),
                                            child: Text(
                                              " دروسي",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: List.generate(
                                                state.lessons.length,
                                                    (index) =>
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          right: 10.0),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (_) =>
                                                                  MyLesson(
                                                                    lessonName: state.lessons[index].title,
                                                                    circleId: state.circleId,
                                                                  ),
                                                            ),
                                                          );
                                                        },
                                                        child: buildLessonHomeScreenCard(
                                                            context, state
                                                            .lessons[index],
                                                          state.circleId,
                                                        ),
                                                      ),
                                                    ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                right: 30.0),
                                            child: Text(
                                              "انجازي",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: List.generate(
                                                state.achievements.length,
                                                    (index) =>
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          right: 10),
                                                      child: buildachivmenHomeScreenCard(
                                                          context,
                                                          state
                                                              .achievements[index]),
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    } else if (state is HomeLoading) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    } else if (state is HomeError) {
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
                      ],
                    ),
                  ),
                );

            }
              else if (state is HomeError) {
                return Scaffold(
                  body: Center(child: Text(state.message)),
                );
              }
              return const SizedBox.shrink();
              return const SizedBox.shrink();
            })
    );
  }
}


