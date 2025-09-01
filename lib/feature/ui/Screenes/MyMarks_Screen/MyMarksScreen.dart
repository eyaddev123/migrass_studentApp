import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/core/api/dio_consumer.dart';
import 'package:student/core/resource/colors_manager.dart';
import 'package:student/core/resource/icon_image_manager.dart';
import 'package:student/core/resource/image_manager.dart';
import 'package:student/feature/ui/Screenes/MyMarks_Screen/bloc/blocMarks.dart';
import 'package:student/feature/ui/Screenes/MyMarks_Screen/bloc/eventsMarks.dart';
import 'package:student/feature/ui/Screenes/MyMarks_Screen/bloc/statesMarks.dart';

class Mymarksscreen extends StatelessWidget {
  final int circleId;
  const Mymarksscreen({super.key, required this.circleId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MarksBloc(DioConsumer(Dio()))..add(LoadMarksEvent(circleId)),
      child: Scaffold(
        backgroundColor: ColorManager.white,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 18, right: 18, left: 13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "علامتي",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: ColorManager.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        IconButton(
                          icon: Image.asset(
                            IconImageManager.blackNewspaper,
                            width: 45,
                            height: 45,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Expanded(
                child: BlocBuilder<MarksBloc, MarksState>(
                  builder: (context, state) {
                    if (state is MarksLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is MarksLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is MarksLoaded) {
                      return ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: state.marks.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 5),
                        itemBuilder: (context, index) {
                          final item = state.marks[index];
                          return gradientInfoTile(
                            icon: Image.asset(item['icon'], width: 20, height: 20),
                            title: item['title'],
                            subtitle: "علامتك: ${item['count']}",
                          );
                        },
                      );
                    } else if (state is MarksError) {
                      return Center(child: Text(state.message));
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),


              Image.asset(
                ImageManager().upscalemediaTransform,
                width: double.infinity,
                height: 250.0,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


Widget gradientInfoTile({
  required Widget icon,
  required String title,
  required String subtitle,

}) =>
    Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: ColorManager.white,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              ColorManager.accentYellow,
              ColorManager.accentRed,
              ColorManager.infoHighlight,
            ],
          ),
        ),
        padding: const EdgeInsets.all(2),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: ColorManager.white,
          ),
          child: Row(
            textDirection: TextDirection.rtl,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.orangeAccent.withOpacity(0.05),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange.withOpacity(0.6),
                      blurRadius: 20,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: icon,
              ),
              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: ColorManager.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                      ),
                    ),
                   const SizedBox(height: 6),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: ColorManager.gray,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
