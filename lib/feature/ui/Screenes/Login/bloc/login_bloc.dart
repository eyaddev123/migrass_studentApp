
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/core/api/dio_consumer.dart';
import 'package:student/core/error/handle_dio_error.dart';
import 'package:student/feature/ui/Screenes/Login/bloc/login_eventes.dart';
import 'package:student/feature/ui/Screenes/Login/bloc/login_states.dart';

class LoginBloc extends Bloc<LoginEventes, LoginState> {
  LoginBloc() : super(LoginState()) {

    on<code_userloginvalue >((event, emit) {
      emit(state.copyWith(code_user: event.code_user));
    });

    on<mosque_codeloginvalue>((event, emit) {
      emit(state.copyWith(mosque_code: event.mosque_code));
    });


    on<LoginSubmitted>((event, emit) async {
      emit(state.copyWith(status: LoginStatus.submitting));
      String fcmToken = "";
      try {
        fcmToken = await FirebaseMessaging.instance.getToken() ?? "not_found"; // TODO: Get actual FCM token
      } catch (e) {
        fcmToken = "not_found";
      }

      try {
        final api = DioConsumer(  BaseOptions(
          baseUrl: "https://api.devscape.online",
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
        ),
        );

        final response = await api.post(
          "/api/auth/login",
          data: {
            'code_user': state.code_user,
            'mosque_code': state.mosque_code,
            "fcm_token": fcmToken,
          },
        );

        if (response.statusCode == 200) {
          final token = response.data['token'];
          emit(state.copyWith(
            status: LoginStatus.success,
            token: token, ));
        }

      }
      on DioException catch (e) {
        try {
          HandleDioException(e);
        } catch (errorMessage) {
          emit(state.copyWith(
            status: LoginStatus.failure,
            errorMessage: errorMessage.toString(),
          ));
        }
      }
      catch (e) {
        emit(state.copyWith(
          status: LoginStatus.failure,
          errorMessage: 'حدث خطأ: $e',
        ));
      }
    });
    //  });
  }
}