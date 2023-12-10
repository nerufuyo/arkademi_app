import 'package:arkademi_app/data/models/course.dart';
import 'package:arkademi_app/data/repositories/repository.dart';

class GetCourses {
  final Repository repository;

  GetCourses(this.repository);

  Future<Course> call() async {
    return await repository.getCourses();
  }
}
