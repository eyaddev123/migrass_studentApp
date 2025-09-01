import 'package:equatable/equatable.dart';

class SendRecordState extends Equatable {
  final String? selectedSurah;
  final int fromAya;
  final int toAya;

  const SendRecordState({
    this.selectedSurah,
    this.fromAya = 1,
    this.toAya = 20,
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
  const SendRecordSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class SendRecordFailure extends SendRecordState {
  final String error;
  const SendRecordFailure(this.error);

  @override
  List<Object?> get props => [error];
}

