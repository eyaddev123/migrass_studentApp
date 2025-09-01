import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student/core/api/dio_consumer.dart';
import 'package:student/core/widgets/Models.dart';
import 'package:student/feature/ui/Screenes/lessons_screen/bloc/lesson_States.dart';
import 'package:student/feature/ui/Screenes/lessons_screen/bloc/lesson_eventes.dart';


class LessonBloc extends Bloc<LessonEvent, LessonState> {
  final DioConsumer dioConsumer = DioConsumer(Dio());
  final int circleId;

  LessonBloc(this.circleId) : super(LessonInitial()) {
    on<LoadLessons>((event, emit) async {
      emit(LessonLoading());
      try {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString("token");

        if (token == null) {
          emit(LessonError("لم يتم العثور على التوكن"));
          return;
        }

        final response = await dioConsumer.get(
          "/api/circle/showCircleForStudent",
          options: Options(
            headers: {
              "Authorization": "Bearer $token",
              "accept": "application/json",
            },
          ),
        );


        final data = response.data['circles'] as List;
        final filtered = data
            .where((e) => e['id'].toString() == circleId.toString())
            .map((e) => LessonModel.fromJson(e))
            .toList();

        emit(LessonLoaded(filtered));
      } catch (e) {
        emit(LessonError("فشل تحميل الدروس: $e"));
      }
    });
  }
}
