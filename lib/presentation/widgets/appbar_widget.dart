import 'package:arkademi_app/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../config/routes.dart';

AppBar appBarWidget(
  context, {
  required title,
  required progress,
}) {
  return AppBar(
    surfaceTintColor: AppColors().white,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTypographies().headline4,
          overflow: TextOverflow.ellipsis,
        ),
        CircularPercentIndicator(
          center: Text(
            '$progress%',
            style: AppTypographies().caption.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          addAutomaticKeepAlive: true,
          animation: true,
          animateFromLastPercent: true,
          animationDuration: 500,
          backgroundColor: Colors.grey.shade200,
          circularStrokeCap: CircularStrokeCap.round,
          lineWidth: 4,
          progressColor: AppColors().success,
          percent: double.parse(progress) / 100,
          radius: 20,
          restartAnimation: true,
        ),
      ],
    ),
    leading: IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => Navigator.pushReplacementNamed(context, Routes.splash),
    ),
  );
}
