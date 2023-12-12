import 'package:arkademi_app/data/models/course.dart';
import 'package:arkademi_app/data/models/curriculum.dart';
import 'package:arkademi_app/data/repositories/repository.dart';
import 'package:arkademi_app/domain/usecase/get_courses.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GetCourses', () {
    test('should return a Course object from the repository', () async {
      // Arrange
      final repository = MockRepository();
      final getCourses = GetCourses(repository);

      // Act
      final result = await getCourses();

      // Assert
      expect(result, isA<Course>());

      // Assert that the result has a courseName property
      expect(result.courseName, isA<String>());
    });
  });
}

// MockRepository class to use in testing
class MockRepository implements Repository {
  @override
  Future<Course> getCourses() async {
    // Return a mock Course object for testing
    return Course(
      courseName: 'Course Name',
      progress: '100',
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
      ],
    );
  }
}
