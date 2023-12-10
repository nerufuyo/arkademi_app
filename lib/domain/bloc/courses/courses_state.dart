part of 'courses_bloc.dart';

sealed class CoursesState {}

class CoursesLoading extends CoursesState {}

class CoursesLoaded extends CoursesState {
  final Course course;

  CoursesLoaded(this.course);
}

class CoursesError extends CoursesState {
  final String message;

  CoursesError(this.message);
}
