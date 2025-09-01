

import 'package:equatable/equatable.dart';

abstract class MarksEvent extends Equatable {
  const MarksEvent();

  @override
  List<Object?> get props => [];
}

class LoadMarksEvent extends MarksEvent {
  final int circleId;
  const LoadMarksEvent(this.circleId);

  @override
  List<Object?> get props => [circleId];
}
