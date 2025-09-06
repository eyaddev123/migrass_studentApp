import 'package:equatable/equatable.dart';

class RecordingData {
  final int? id;
  final String filePath;
  final List<double> waveData;
  final Duration duration;
    int? serverId;
  final bool isLocal;
  final String? remoteUrl;


  RecordingData({
    this.id,
    required this.filePath,
    required this.waveData,
    required this.duration,
    this.serverId,
    this.isLocal = true,
    this.remoteUrl,

  });
}

class RecordingState extends Equatable {
  final bool isRecorderReady;
  final bool isRecording;
  final bool isPaused;
  final bool isPlaying;
  final bool isLoading;
  final String? currentPlayingPath;
  final List<RecordingData> recordings;
  final List<double> waveData;

  const RecordingState({
    this.isRecorderReady = false,
    this.isRecording = false,
    this.isPaused = false,
    this.isPlaying = false,
    this.isLoading = false,
    this.currentPlayingPath,
    this.recordings = const [],
    this.waveData = const [],
  });

  RecordingState copyWith({
    bool? isRecorderReady,
    bool? isRecording,
    bool? isPaused,
    bool? isPlaying,
    bool? isLoading,
    String? currentPlayingPath,
    List<RecordingData>? recordings,
    List<double>? waveData,
  }) {
    return RecordingState(
      isRecorderReady: isRecorderReady ?? this.isRecorderReady,
      isRecording: isRecording ?? this.isRecording,
      isPaused: isPaused ?? this.isPaused,
      isPlaying: isPlaying ?? this.isPlaying,
      isLoading: isLoading ?? this.isLoading,
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

class RecordingPlaying extends RecordingState {
  final String path;
  const RecordingPlaying(this.path);
}

class RecordingStopped extends RecordingState {
  const RecordingStopped();
}

class RecordingError extends RecordingState {
  final String message;
  const RecordingError(this.message);
}

