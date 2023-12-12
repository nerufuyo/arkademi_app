import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:path_provider/path_provider.dart';

class EncryptionHelper {
  Uint8List generateRandomIV() {
    final random = Random.secure();
    final iv = List<int>.generate(16, (_) => random.nextInt(256));
    return Uint8List.fromList(iv);
  }

  Future<void> saveEncryptedFile(
    context, {
    required String fileName,
    required Uint8List fileData,
    required String encryptionKey,
  }) async {
    // Encrypt the file data with the provided secret key
    final key = encrypt.Key.fromUtf8(encryptionKey);
    final iv = encrypt.IV(generateRandomIV());
    final encrypter =
        encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));
    final encryptedFileData = encrypter.encryptBytes(fileData, iv: iv);

    // Get the external storage directory
    Directory? externalDirectory = await getApplicationDocumentsDirectory();

    String savePath = '${externalDirectory.path}/$fileName';

    // Save the encrypted data to a file
    File file = File(savePath);
    await file.writeAsBytes(encryptedFileData.bytes);
  }

  Future<void> encryptFileInLocal({
    required String filePath,
    required String secretKey,
  }) async {
    try {
      final key = encrypt.Key.fromUtf8(secretKey);
      final iv = encrypt.IV(generateRandomIV());
      final encrypter =
          encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));

      final fileData = await File(filePath).readAsBytes();
      final encryptedFileData = encrypter.encryptBytes(fileData, iv: iv);

      // Write the encrypted data back to the same file
      await File(filePath).writeAsBytes(encryptedFileData.bytes);
    } catch (error) {
      print('Error encrypting file: $error');
      rethrow; // Rethrow the exception after logging or handling the error
    }
  }

  Future<String?> loadDecryptedFile({
    required String filePath,
    required String encryptionKey,
  }) async {
    try {
      final key = encrypt.Key.fromUtf8(encryptionKey);
      final iv = encrypt.IV.fromLength(16);

      final encrypter =
          encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));
      final encryptedFileData = await File(filePath).readAsBytes();

      final decryptedFileData = encrypter.decrypt(
        encrypt.Encrypted(Uint8List.fromList(encryptedFileData)),
        iv: iv,
      );

      // Write the decrypted data to a temporary file
      File tempFile = File(filePath);
      await tempFile.writeAsBytes(decryptedFileData.codeUnits);

      return tempFile.path;
    } catch (error) {
      return null;
    }
  }
}
