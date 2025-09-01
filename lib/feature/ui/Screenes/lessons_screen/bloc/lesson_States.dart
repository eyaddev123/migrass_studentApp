import 'package:student/core/widgets/Models.dart';

abstract class LessonState {}

class LessonInitial extends LessonState {}

class LessonLoading extends LessonState {}

class LessonLoaded extends LessonState {
  final List<LessonModel> lessons;

  LessonLoaded(this.lessons);
}

class LessonError extends LessonState {
  final String message;

  LessonError(this.message);
}
