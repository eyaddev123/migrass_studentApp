import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/feature/ui/Screenes/MyExam_Screen/bloc/evevtExam.dart';
import 'package:student/feature/ui/Screenes/MyExam_Screen/bloc/stateExam.dart';
import 'package:student/core/api/dio_consumer.dart';
import 'package:dio/dio.dart';
import 'package:student/core/resource/icon_image_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubjectBloc extends Bloc<SubjectEvent, SubjectState> {
  final DioConsumer api;

  SubjectBloc(this.api) : super(SubjectInitial()) {
    on<LoadSubjectsEvent>(_onLoadSubjects);
  }

  Future<void> _onLoadSubjects(
      LoadSubjectsEvent event, Emitter<SubjectState> emit) async {
    try {
      emit(SubjectLoading());

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token") ?? "";

      if (token.isEmpty) {
        emit(SubjectError("التوكن غير موجود، سجل الدخول أولاً"));
        return;
      }

      final response = await api.get(
        "/api/Circle/dars-with-exams",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      final List<dynamic> data = response.data["AllCircles"];

      final subjects = data.map((circle) {
        return {
          "title": circle["circle_name"],
          "count": circle["exams_count"].toString(),
          "icon": IconImageManager.doucument,
        };
      }).toList();

      emit(SubjectLoaded(subjects));
    } catch (e) {
      emit(SubjectError("فشل تحميل المواد: $e"));
    }
  }
}

