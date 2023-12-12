import 'package:arkademi_app/data/models/curriculum.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Curriculum', () {
    test('fromJson and toJson should work correctly', () {
      // Arrange
      final curriculum = Curriculum(
        key: 1,
        id: 'ABC123',
        type: 'video',
        title: 'Introduction to Programming',
        duration: 120,
        content: 'Programming basics',
        meta: ['beginner', 'coding'],
        status: 1,
        onlineVideoLink: 'https://example.com/online-video',
        offlineVideoLink: 'file:///storage/emulated/0/videos/offline.mp4',
      );

      // Act
      final Map<String, dynamic> json = curriculum.toJson();
      final Curriculum fromJson = Curriculum.fromJson(json);

      // Assert
      expect(fromJson.key, curriculum.key);
      expect(fromJson.id, curriculum.id);
      expect(fromJson.type, curriculum.type);
      expect(fromJson.title, curriculum.title);
      expect(fromJson.duration, curriculum.duration);
      expect(fromJson.content, curriculum.content);
      expect(fromJson.meta!.length, curriculum.meta!.length);
      expect(fromJson.status, curriculum.status);
      expect(fromJson.onlineVideoLink, curriculum.onlineVideoLink);
      expect(fromJson.offlineVideoLink, curriculum.offlineVideoLink);
    });
  });
}
