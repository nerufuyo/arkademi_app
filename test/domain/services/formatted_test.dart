import 'package:arkademi_app/domain/services/formatted.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('formatDuration', () {
    test('should format duration less than 1 hour', () {
      // Arrange
      const int seconds = 1500; // 25 minutes

      // Act
      final result = formatDuration(seconds);

      // Assert
      expect(result, '25 menit');
    });

    test('should format duration equal to 1 hour', () {
      // Arrange
      const int seconds = 3600; // 1 hour

      // Act
      final result = formatDuration(seconds);

      // Assert
      expect(result, '1 jam 0 menit');
    });

    test('should format duration greater than 1 hour', () {
      // Arrange
      const int seconds = 4500; // 1 hour and 15 minutes

      // Act
      final result = formatDuration(seconds);

      // Assert
      expect(result, '1 jam 15 menit');
    });
  });
}
