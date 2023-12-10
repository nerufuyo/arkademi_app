import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<void> saveJsonToSecureStorage(
    String key,
    List<Map<String, dynamic>> jsonData,
  ) async {
    // Convert the list of maps to a JSON string
    String jsonString = jsonEncode(jsonData);

    // Save the JSON string to secure storage
    await _secureStorage.write(key: key, value: jsonString);
  }

  Future<List<Map<String, dynamic>>> getJsonFromSecureStorage(
    String key,
  ) async {
    // Read the JSON string from secure storage
    String? jsonString = await _secureStorage.read(key: key);

    // Convert the JSON string to a list of maps
    if (jsonString != null) {
      return (jsonDecode(jsonString) as List<dynamic>)
          .cast<Map<String, dynamic>>();
    } else {
      return [];
    }
  }

  Future<void> deleteJsonFromSecureStorage(String key) async {
    await _secureStorage.delete(key: key);
  }
}
