
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:student/core/api/dio_consumer.dart';
import 'package:student/core/widgets/Models.dart';
import 'package:student/feature/ui/Screenes/Home_Screen/HomeScreen/bloc_home/home_eventes.dart';
import 'package:student/feature/ui/Screenes/Home_Screen/HomeScreen/bloc_home/home_states.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final DioConsumer api;

  HomeBloc(this.api) : super(HomeInitial()) {
    on<LoadHomeData>((event, emit) async {
      emit(HomeLoading());
      try {

        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString("token") ?? "";

        if (token.isEmpty) {
          emit(HomeError("لا يوجد توكن، يرجى تسجيل الدخول مجدداً"));
          return;
        }


        final response = await api.get(
          "/api/circle/showCircleForStudent",
          options: Options(
            headers: {
              "Authorization": "Bearer $token",
            },
          ),
        );


        final data = response.data['circles'] as List;
        List<LessonHomeScreenModel> allLessons =
        data.map((e) => LessonHomeScreenModel.fromJson(e)).toList();

        final circleId = data.isNotEmpty ? data[0]['id'] as int : 0;

        emit(HomeLoaded(
          circleId: circleId,
          lessons: allLessons,
          achievements: [],
        ));
      } catch (e) {
        emit(HomeError("فشل تحميل البيانات: $e"));
      }
    });
  }
}
