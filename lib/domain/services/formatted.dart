String formatDuration(int seconds) {
  if (seconds < 3600) {
    final int minutes = seconds ~/ 60;
    return '$minutes menit';
  } else {
    final int hours = seconds ~/ 3600;
    final int remainingMinutes = (seconds % 3600) ~/ 60;
    return '$hours jam $remainingMinutes menit';
  }
}
