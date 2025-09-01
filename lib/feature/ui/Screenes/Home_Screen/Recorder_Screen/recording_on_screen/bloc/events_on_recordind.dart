import 'package:equatable/equatable.dart';

abstract class SendRecordEvent extends Equatable {
  const SendRecordEvent();

  @override
  List<Object?> get props => [];
}

class SelectSurah extends SendRecordEvent {
  final String surah;
  const SelectSurah(this.surah);

  @override
  List<Object?> get props => [surah];
}

class SelectFromAya extends SendRecordEvent {
  final int fromAya;
  const SelectFromAya(this.fromAya);

  @override
  List<Object?> get props => [fromAya];
}

class SelectToAya extends SendRecordEvent {
  final int toAya;
  const SelectToAya(this.toAya);

  @override
  List<Object?> get props => [toAya];
}
class UploadRecord extends SendRecordEvent {
  final String filePath;
  final int surahId;
  final int fromAya;
  final int toAya;

  const UploadRecord({
    required this.filePath,
    required this.surahId,
    required this.fromAya,
    required this.toAya,
  });

  @override
  List<Object?> get props => [filePath, surahId, fromAya, toAya];
}

