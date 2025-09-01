import 'package:equatable/equatable.dart';

class RecordingData {
  final String filePath;
  final List<double> waveData;
  final Duration duration;
  final int? serverId;
  final bool isLocal;

  RecordingData({
    required this.filePath,
    required this.waveData,
    required this.duration,
    this.serverId,
    this.isLocal = true,
  });
}

class RecordingState extends Equatable {
  final bool isRecorderReady;
  final bool isRecording;
  final bool isPaused;
  final bool isPlaying;
  final String? currentPlayingPath;
  final List<RecordingData> recordings;
  final List<double> waveData;

  const RecordingState({
    this.isRecorderReady = false,
    this.isRecording = false,
    this.isPaused = false,
    this.isPlaying = false,
    this.currentPlayingPath,
    this.recordings = const [],
    this.waveData = const [],
  });

  RecordingState copyWith({
    bool? isRecorderReady,
    bool? isRecording,
    bool? isPaused,
    bool? isPlaying,
    String? currentPlayingPath,
    List<RecordingData>? recordings,
    List<double>? waveData,
  }) {
    return RecordingState(
      isRecorderReady: isRecorderReady ?? this.isRecorderReady,
      isRecording: isRecording ?? this.isRecording,
      isPaused: isPaused ?? this.isPaused,
      isPlaying: isPlaying ?? this.isPlaying,
      currentPlayingPath: currentPlayingPath,
      recordings: recordings ?? this.recordings,
      waveData: waveData ?? this.waveData,
    );
  }

  @override
  List<Object?> get props => [
    isRecorderReady,
    isRecording,
    isPaused,
    isPlaying,
    currentPlayingPath,
    recordings,
    waveData,
  ];
}
