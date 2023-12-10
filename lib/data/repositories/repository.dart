import 'package:arkademi_app/config/routes.dart';
import 'package:arkademi_app/data/models/course.dart';
import 'package:arkademi_app/domain/services/constant.dart';
import 'package:dio/dio.dart';
import 'package:dotenv/dotenv.dart';

abstract class Repository {
  Future<Course> getCourses();
}

class RepositoryImplement implements Repository {
  final Dio dio;
  final baseUrl = DotEnv().isEveryDefined(['BASE_URL']);

  RepositoryImplement(this.dio);

  @override
  Future<Course> getCourses() async {
    final response = await dio.get(
      '${Secrets.baseUrl}${ApiEndpoints.course}',
    );

    try {
      if (response.statusCode == 200) {
        return Course.fromJson(response.data);
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error Catch: $error');
    }
  }
}
