class AudioDetailsModel {
  final int id;
  final String filePath;
  final int fromAyahId;
  final int toAyahId;
  final String surahName;
  final List<CommentModel> comments;

  AudioDetailsModel({
    required this.id,
    required this.filePath,
    required this.fromAyahId,
    required this.toAyahId,
    required this.surahName,
    required this.comments,
  });

  factory AudioDetailsModel.fromJson(Map<String, dynamic> json) {
    return AudioDetailsModel(
      id: json['audio']['id'],
      filePath: json['audio']['filePath'],
      fromAyahId: json['audio']['from_ayah_id'],
      toAyahId: json['audio']['to_ayah_id'],
      surahName: json['audio']['surah_name'],
      comments: (json['comment'] as List<dynamic>)
          .map((c) => CommentModel.fromJson(c))
          .toList(),
    );
  }
}

class CommentModel {
  final int id;
  final String text;
  final int rate;

  CommentModel({
    required this.id,
    required this.text,
    required this.rate,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      text: json['text'] ?? "",
      rate: json['rate'] ?? 0,
    );
  }
}
