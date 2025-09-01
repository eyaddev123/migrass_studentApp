
import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student/core/api/dio_consumer.dart';
import 'package:student/feature/ui/Screenes/Home_Screen/Recorder_Screen/record_screen/bloc/events_record.dart';
import 'package:student/feature/ui/Screenes/Home_Screen/Recorder_Screen/record_screen/bloc/states_record.dart';

class RecordingBloc extends Bloc<RecordingEvent, RecordingState> {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  final FlutterSoundPlayer _player = FlutterSoundPlayer();
  Timer? _waveTimer;
  Stopwatch _stopwatch = Stopwatch();
  final Random _random = Random();

  RecordingBloc() : super(const RecordingState()) {
    on<InitRecorder>(_onInitRecorder);
    on<StartRecording>(_onStartRecording);
    on<StopRecording>(_onStopRecording);
    on<PauseRecording>(_onPauseRecording);
    on<ResumeRecording>(_onResumeRecording);
    on<PlayRecording>(_onPlayRecording);
    on<DeleteRecording>(_onDeleteRecording);
    on<UpdateWaveform>(_onUpdateWaveform);
    on<StopPlaying>(_onStopPlaying);

    _player.openPlayer();
  }

  Future<void> _onInitRecorder(
      InitRecorder event, Emitter<RecordingState> emit) async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Permission not granted');
    }
    await _recorder.openRecorder();
    emit(state.copyWith(isRecorderReady: true));

    await fetchServerRecordings();
  }

  Future<String> _getFilePath() async {
    final dir = await getApplicationDocumentsDirectory();
    return "${dir.path}/recording_${DateTime.now().millisecondsSinceEpoch}.aac";
  }

  Future<void> fetchServerRecordings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");

      if (token == null) {
        debugPrint("No token found in SharedPreferences");
        return;
      }

      final response = await DioConsumer(Dio()).get(
        '/api/UserAudio/getAllAudiosForStudent',
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );


      debugPrint("Server response: ${response.data}");

      final audios = response.data['audios'] as List? ?? [];

      final serverRecordings = audios.map((e) => RecordingData(
        filePath: "http://192.168.1.108:4000${e['file']}",
        waveData: List.generate(20, (i) => Random().nextDouble()),
        duration: Duration.zero,
        serverId: e['id'],
        isLocal: false,
      )).toList();

      emit(state.copyWith(recordings: serverRecordings));
    } catch (e) {
      debugPrint("Error fetching server recordings: $e");
    }
  }


  Future<void> _onStartRecording(
      StartRecording event, Emitter<RecordingState> emit) async {
    if (!state.isRecorderReady) return;
    final path = await _getFilePath();
    await _recorder.startRecorder(toFile: path, codec: Codec.aacADTS);
    _stopwatch.reset();
    _stopwatch.start();

    _waveTimer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      add(UpdateWaveform(_random.nextDouble()));
    });

    emit(state.copyWith(isRecording: true, waveData: []));
  }

  Future<void> _onStopRecording(
      StopRecording event, Emitter<RecordingState> emit) async {
    final path = await _recorder.stopRecorder();
    _waveTimer?.cancel();
    _stopwatch.stop();

    if (path != null) {
      final rec = RecordingData(
        filePath: path,
        waveData: List.from(state.waveData),
        duration: _stopwatch.elapsed,
        isLocal: true,
      );
      final updated = List<RecordingData>.from(state.recordings)..add(rec);
      emit(state.copyWith(
        isRecording: false,
        isPaused: false,
        recordings: updated,
        waveData: [],
      ));
    }
  }

  Future<void> _onPauseRecording(
      PauseRecording event, Emitter<RecordingState> emit) async {
    await _recorder.pauseRecorder();
    _waveTimer?.cancel();
    emit(state.copyWith(isPaused: true));
  }

  Future<void> _onResumeRecording(
      ResumeRecording event, Emitter<RecordingState> emit) async {
    await _recorder.resumeRecorder();
    _waveTimer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      add(UpdateWaveform(_random.nextDouble()));
    });
    emit(state.copyWith(isPaused: false));
  }

  Future<void> _onPlayRecording(
      PlayRecording event, Emitter<RecordingState> emit) async {
    if (state.isPlaying && state.currentPlayingPath == event.path) {
      await _player.stopPlayer();
      emit(state.copyWith(isPlaying: false, currentPlayingPath: null));
      return;
    }

    await _player.startPlayer(
      fromURI: event.path,
      codec: Codec.aacADTS,
      whenFinished: () {
        add(StopPlaying());
      },
    );

    emit(state.copyWith(isPlaying: true, currentPlayingPath: event.path));
  }

  Future<void> _onStopPlaying(
      StopPlaying event, Emitter<RecordingState> emit) async {
    emit(state.copyWith(isPlaying: false, currentPlayingPath: null));
  }

  Future<void> _onDeleteRecording(
      DeleteRecording event, Emitter<RecordingState> emit) async {
    final recs = List<RecordingData>.from(state.recordings);
    final rec = recs[event.index];

    if (rec.isLocal) {
      File(rec.filePath).deleteSync();
    } else if (rec.serverId != null) {
      try {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString("token");
        await DioConsumer(Dio()).delete(
          '/api/UserAudio/delete/${rec.serverId}',
          options: Options(
            headers: {
              "Authorization": "Bearer $token",
            },
          ),
        );
        print("تم الحذف الحمدلله ");
      } catch (e) {
        debugPrint("Error deleting server recording: $e");
        return;
      }
    }

    recs.removeAt(event.index);
    emit(state.copyWith(recordings: recs));
  }

  void _onUpdateWaveform(
      UpdateWaveform event, Emitter<RecordingState> emit) {
    final updated = List<double>.from(state.waveData)..add(event.value);
    if (updated.length > 30) updated.removeAt(0);
    emit(state.copyWith(waveData: updated));
  }

  @override
  Future<void> close() {
    _recorder.closeRecorder();
    _player.closePlayer();
    _waveTimer?.cancel();
    return super.close();
  }
}
