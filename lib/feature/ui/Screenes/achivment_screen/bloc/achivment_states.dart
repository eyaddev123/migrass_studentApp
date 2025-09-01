
import 'package:student/core/widgets/Models.dart';

abstract class AchivmentState {}

class AchivmentInitial extends AchivmentState {}

class AchivmentLoading extends AchivmentState {}

class AchivmentLoaded extends AchivmentState {
  final List<achivmentModel> achivments;

  AchivmentLoaded(this.achivments);
}

class AchivmentError extends AchivmentState {
  final String message;

  AchivmentError(this.message);
}
