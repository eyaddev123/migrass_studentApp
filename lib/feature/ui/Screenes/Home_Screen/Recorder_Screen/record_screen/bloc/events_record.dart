import 'package:equatable/equatable.dart';

abstract class RecordingEvent extends Equatable {
  const RecordingEvent();

  @override
  List<Object?> get props => [];
}

class InitRecorder extends RecordingEvent {}

class StartRecording extends RecordingEvent {}

class StopRecording extends RecordingEvent {}

class PauseRecording extends RecordingEvent {}

class ResumeRecording extends RecordingEvent {}

class StopPlaying extends RecordingEvent {}


class PlayRecording extends RecordingEvent {
  final String path;
  final String remoteUrl;
  const PlayRecording(this.path, this.remoteUrl);

  @override
  List<Object?> get props => [path];
}

class DeleteRecording extends RecordingEvent {
  final int index;
  const DeleteRecording(this.index);

  @override
  List<Object?> get props => [index];
}

class UpdateWaveform extends RecordingEvent {
  final double value;
  const UpdateWaveform(this.value);

  @override
  List<Object?> get props => [value];
}
