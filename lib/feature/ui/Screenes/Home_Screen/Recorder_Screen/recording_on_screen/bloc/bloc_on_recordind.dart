import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student/core/api/dio_consumer.dart';
import 'package:student/feature/ui/Screenes/Home_Screen/Recorder_Screen/recording_on_screen/bloc/events_on_recordind.dart';
import 'package:student/feature/ui/Screenes/Home_Screen/Recorder_Screen/recording_on_screen/bloc/states_on_recordind.dart';


class SendRecordBloc extends Bloc<SendRecordEvent, SendRecordState> {
  final DioConsumer api = DioConsumer(Dio());

  SendRecordBloc() : super(const SendRecordState()) {
    on<SelectSurah>((event, emit) {
      emit(state.copyWith(selectedSurah: event.surah));
    });

    on<SelectFromAya>((event, emit) {
      emit(state.copyWith(fromAya: event.fromAya));
    });

    on<SelectToAya>((event, emit) {
      emit(state.copyWith(toAya: event.toAya));
    });
    on<UploadRecord>((event, emit) async {
      emit(const SendRecordUploading());
      try {
        // اقرأ التوكن
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString("token"); // اسم المفتاح اللي خزنت فيه التوكن

        if (token == null) {
          emit(const SendRecordFailure("التوكن غير موجود"));
          return;
        }

        final formData = FormData.fromMap({
          "audio": await MultipartFile.fromFile(
            event.filePath,
            filename: "record.mp3",
          ),
          "surah_id": event.surahId,
          "from_ayah_id": event.fromAya,
          "to_ayah_id": event.toAya,
        });

        final response = await api.post(
          "/api/UserAudio/uploadAudio",
          data: formData,
          options: Options(
            headers: {
              "Authorization": "Bearer $token",
            },
          ),
        );

        emit(SendRecordSuccess(response.data["message"]));
      } catch (e) {
        emit(SendRecordFailure(e.toString()));
      }
    });
  }

}
