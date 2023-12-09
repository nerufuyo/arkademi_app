import 'package:arkademi_app/config/routes.dart';
import 'package:arkademi_app/domain/bloc/courses/courses_bloc.dart';
import 'package:arkademi_app/injection.dart' as di;
import 'package:arkademi_app/presentation/screens/splash_screen.dart';
import 'package:dotenv/dotenv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  di.setupLocator();
  DotEnv().load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.locator<CoursesBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Arkademi App',
        initialRoute: Routes.splash,
        routes: <String, WidgetBuilder>{
          Routes.splash: (BuildContext context) => const SplashScreen(),
          Routes.course: (BuildContext context) => const CourseScreen(),
        },
      ),
    );
  }
}
