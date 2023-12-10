import 'package:arkademi_app/config/routes.dart';
import 'package:arkademi_app/config/theme.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void navigateToNextScreen(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushNamed(context, Routes.course);
    });
  }

  @override
  void initState() {
    navigateToNextScreen(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/arkademi-logo.png',
                width: MediaQuery.of(context).size.width * 0.5,
              ),
              Text(
                'ARKADEMI',
                style: AppTypographies().headline1.copyWith(
                      color: AppColors().primary,
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
