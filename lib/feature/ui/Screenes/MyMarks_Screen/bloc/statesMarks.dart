import 'package:equatable/equatable.dart';

abstract class MarksState extends Equatable {
  const MarksState();

  @override
  List<Object?> get props => [];
}

class MarksInitial extends MarksState {}

class MarksLoading extends MarksState {}

class MarksLoaded extends MarksState {
  final List<Map<String, dynamic>> marks;

  const MarksLoaded(this.marks);

  @override
  List<Object?> get props => [marks];
}

class MarksError extends MarksState {
  final String message;

  const MarksError(this.message);

  @override
  List<Object?> get props => [message];
}
