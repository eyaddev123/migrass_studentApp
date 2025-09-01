

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/core/resource/colors_manager.dart';
import 'package:student/core/resource/icon_image_manager.dart';
import 'package:student/core/resource/image_manager.dart';
import 'package:student/core/widgets/Models.dart';
import 'package:student/feature/ui/Screenes/achivment_screen/bloc/achivment_bloc.dart';
import 'package:student/feature/ui/Screenes/achivment_screen/bloc/achivment_eventes.dart';
import 'package:student/feature/ui/Screenes/achivment_screen/bloc/achivment_states.dart';

class MyAchivment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AchivmentBloc()..add(LoadAchivments()),
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
                              const Padding(
                                padding: EdgeInsets.only(top: 6, right: 60),
                                child: Text(
                                  "\nانجازي\n"
                                      "قرآن",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: ColorManager.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25.0,
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
                        BlocBuilder<AchivmentBloc, AchivmentState>(
                          builder: (context, state) {
                            if (state is AchivmentLoaded) {
                              return ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) =>
                                    buildachivmentCard(state.achivments[index]),
                                separatorBuilder: (context, index) =>
                                const SizedBox(height: 40.0),
                                itemCount: state.achivments.length,
                              );
                            } else if (state is AchivmentLoading) {
                              return const Center(child: CircularProgressIndicator());
                            } else if (state is AchivmentError) {
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
