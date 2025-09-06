import 'package:student/feature/ui/Screenes/Home_Screen/Recorder_Screen/recorder_details/Model_Recorder_Details.dart';

class RecordDetailsState {
  final bool isPlaying;
  final int rating;
  final bool isLoading;
  final AudioDetailsModel? audioDetails;
  final String? error;

  RecordDetailsState({
    this.isPlaying = false,
    this.rating = 0,
    this.isLoading = false,
    this.audioDetails,
    this.error,
  });

  RecordDetailsState copyWith({
    bool? isPlaying,
    int? rating,
    bool? isLoading,
    AudioDetailsModel? audioDetails,
    String? error,
  }) {
    return RecordDetailsState(
      isPlaying: isPlaying ?? this.isPlaying,
      rating: rating ?? this.rating,
      isLoading: isLoading ?? this.isLoading,
      audioDetails: audioDetails ?? this.audioDetails,
      error: error,
    );
  }
}

