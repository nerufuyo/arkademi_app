// ignore_for_file: depend_on_referenced_packages

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:arkademi_app/domain/services/encryption.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group('EncryptionHelper', () {
    test('generateRandomIV should return a Uint8List of length 16', () {
      final encryptionHelper = EncryptionHelper();
      final iv = encryptionHelper.generateRandomIV();

      expect(iv.length, equals(16));
      expect(iv, isA<Uint8List>());
    });
  });
}
