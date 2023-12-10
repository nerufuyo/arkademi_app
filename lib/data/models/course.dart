import 'package:arkademi_app/data/models/curriculum.dart';

class Course {
  final String? courseName;
  final String? progress;
  final List<Curriculum>? curriculum;

  Course({
    required this.courseName,
    required this.progress,
    required this.curriculum,
  });

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        courseName: json["course_name"],
        progress: json["progress"],
        curriculum: List<Curriculum>.from(
            json["curriculum"].map((x) => Curriculum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "course_name": courseName,
        "progress": progress,
        "curriculum": List<dynamic>.from(curriculum!.map((x) => x.toJson())),
      };
}
