import 'package:equatable/equatable.dart';

class SendRecordState extends Equatable {
  final String? selectedSurah;
  final int? fromAya;
  final int? toAya;

  const SendRecordState({
    this.selectedSurah,
    this.fromAya,
    this.toAya,
  });

  SendRecordState copyWith({
    String? selectedSurah,
    int? fromAya,
    int? toAya,
  }) {
    return SendRecordState(
      selectedSurah: selectedSurah ?? this.selectedSurah,
      fromAya: fromAya ?? this.fromAya,
      toAya: toAya ?? this.toAya,
    );
  }

  @override
  List<Object?> get props => [selectedSurah, fromAya, toAya];
}
class SendRecordUploading extends SendRecordState {
  const SendRecordUploading();
}

class SendRecordSuccess extends SendRecordState {
  final String message;
  final int audioId;
  const SendRecordSuccess(this.message, {required this.audioId});
  @override
  List<Object?> get props => [message];
}

class SendRecordFailure extends SendRecordState {
  final String error;
  const SendRecordFailure(this.error);

  @override
  List<Object?> get props => [error];
}

