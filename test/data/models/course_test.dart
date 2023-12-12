import 'package:arkademi_app/data/models/course.dart';
import 'package:arkademi_app/data/models/curriculum.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Course', () {
    test('fromJson and toJson should work correctly', () {
      // Arrange
      final course = Course(
        courseName: 'Math',
        progress: '50%',
        curriculum: [
          Curriculum(
            key: 1,
            id: '1',
            title: 'Curriculum Title',
            type: 'unit',
            duration: 2400,
            content: 'https://www.youtube.com/watch?v=6g3g0Q_XVb4',
            meta: [],
            status: 1,
            onlineVideoLink: 'https://www.youtube.com/watch?v=6g3g0Q_XVb4',
            offlineVideoLink: 'https://www.youtube.com/watch?v=6g3g0Q_XVb4',
          ),
          Curriculum(
            key: 1,
            id: '1',
            title: 'Curriculum Title',
            type: 'unit',
            duration: 2400,
            content: 'https://www.youtube.com/watch?v=6g3g0Q_XVb4',
            meta: [],
            status: 1,
            onlineVideoLink: 'https://www.youtube.com/watch?v=6g3g0Q_XVb4',
            offlineVideoLink: 'https://www.youtube.com/watch?v=6g3g0Q_XVb4',
          ),
        ],
      );

      // Act
      final Map<String, dynamic> json = course.toJson();
      final Course fromJson = Course.fromJson(json);

      // Assert
      expect(fromJson.courseName, course.courseName);
      expect(fromJson.progress, course.progress);
      expect(fromJson.curriculum!.length, course.curriculum!.length);

      for (var i = 0; i < course.curriculum!.length; i++) {
        expect(fromJson.curriculum![i].title, course.curriculum![i].title);
        expect(
            fromJson.curriculum![i].duration, course.curriculum![i].duration);
      }
    });
  });
}
