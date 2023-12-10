import 'package:arkademi_app/data/repositories/repository.dart';
import 'package:arkademi_app/domain/bloc/courses/courses_bloc.dart';
import 'package:arkademi_app/domain/usecase/get_courses.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupLocator() {
  // Bloc Provider
  locator.registerFactory(() => CoursesBloc(locator()));

  // Use Case
  locator.registerLazySingleton(() => GetCourses(locator()));

  // Repository
  locator.registerLazySingleton<Repository>(
    () => RepositoryImplement(locator()),
  );

  // Dio
  locator.registerLazySingleton(() => Dio());
}
