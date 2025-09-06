abstract class RecordDetailsEvent {}

class FetchRecordDetailsEvent extends RecordDetailsEvent {
  final int audioId;
  FetchRecordDetailsEvent(this.audioId);
}

class TogglePlayEvent extends RecordDetailsEvent {}

class UpdateRatingEvent extends RecordDetailsEvent {
  final int rating;
  UpdateRatingEvent(this.rating);
}
