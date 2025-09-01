import 'package:intl/intl.dart';

class LessonModel {
  final String name;
  final String description;
  final String date;

  LessonModel({
    required this.name,
    required this.description,
    required this.date,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    String rawDate = json['created_at'] ?? "";
    String formattedDate = "";

    if (rawDate.isNotEmpty) {
      try {
        DateTime parsedDate = DateTime.parse(rawDate);
        formattedDate = DateFormat('dd/MM/yyyy').format(parsedDate);
      } catch (e) {
        formattedDate = rawDate;
      }
    }

    return LessonModel(
      name: json['name'] ?? "",
      description: json['description'] ?? "",
      date: formattedDate,
    );
  }
}
