
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/core/widgets/Models.dart';
import 'package:student/feature/ui/Screenes/achivment_screen/bloc/achivment_eventes.dart';
import 'package:student/feature/ui/Screenes/achivment_screen/bloc/achivment_states.dart';

class AchivmentBloc extends Bloc<AchivmentEvent, AchivmentState> {
  AchivmentBloc() : super(AchivmentInitial()) {
    on<LoadAchivments>((event, emit) async {
      emit(AchivmentLoading());

      try {
        await Future.delayed(Duration(seconds: 1)); // محاكاة تحميل

        final data = [
          achivmentModel(
            date: "2025_ 01 _ 01",
            doneMyAchivment: " سورة الإسراء من 1 \nإلى 50 من سورة الإسراء ",
          ),
          achivmentModel(
            date: "2024_ 05 _ 07",
            doneMyAchivment: " سورة البقرة من 100 \nإلى 50 من سورة آل عمران ",
          ),
          achivmentModel(
            date: "2025_ 2 _ 06",
            doneMyAchivment: " سورة الإسراء من 1 \nإلى 50 من سورة الإسراء ",
          ),
        ];

        emit(AchivmentLoaded(data));
      } catch (_) {
        emit(AchivmentError("فشل تحميل الإنجازات"));
      }
    });
  }
}
