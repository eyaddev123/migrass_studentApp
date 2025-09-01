import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/core/resource/icon_image_manager.dart';
import 'package:student/feature/ui/Screenes/MyMarks_Screen/bloc/eventsMarks.dart';
import 'package:student/feature/ui/Screenes/MyMarks_Screen/bloc/statesMarks.dart';
import 'package:student/core/api/dio_consumer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MarksBloc extends Bloc<MarksEvent, MarksState> {
  final DioConsumer dio;

  MarksBloc(this.dio) : super(MarksInitial()) {
    on<LoadMarksEvent>(_onLoadMarks);
  }

  Future<void> _onLoadMarks(LoadMarksEvent event, Emitter<MarksState> emit) async {
    try {
      emit(MarksLoading());


      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");
      if (token == null) {
        emit(const MarksError("لم يتم العثور على التوكين"));
        return;
      }

      final circleId = event.circleId;

      final response = await dio.get(
        "/api/exam/getAllMarksForStudent/$circleId",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "accept": "application/json",
          },
        ),
      );

      final results = response.data["results"] as List;

      final List<Map<String, dynamic>> marksList = results.map((exam) {
        return {
          "title": exam["exam_title"],
          "count": "${exam["result_exam"]}",
          "icon":    IconImageManager.doucument,
        };
      }).toList();

      emit(MarksLoaded(marksList));
    } catch (e) {
      emit(MarksError(e.toString()));
    }
  }
}
