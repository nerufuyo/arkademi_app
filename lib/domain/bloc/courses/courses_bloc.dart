import 'package:arkademi_app/data/models/course.dart';
import 'package:arkademi_app/domain/usecase/get_courses.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'courses_event.dart';
part 'courses_state.dart';

class CoursesBloc extends Bloc<CoursesEvent, CoursesState> {
  final GetCourses getCourses;
  CoursesBloc(this.getCourses) : super(CoursesLoading()) {
    on<CoursesEvent>((event, emit) async {
      emit(CoursesLoading());
      try {
        final course = await getCourses();
        emit(CoursesLoaded(course));
      } catch (error) {
        emit(CoursesError(error.toString()));
      }
    });
  }
}
