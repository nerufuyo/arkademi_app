import 'dart:io';
import 'dart:typed_data';

import 'package:arkademi_app/config/theme.dart';
import 'package:arkademi_app/domain/services/encryption.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class TrafficManager {
  Dio dio = Dio();

  Future<void> downloadFile({
    required String fileUrl,
    required String fileName,
    required String encryptionKey,
    required context,
  }) async {
    ProgressDialog progressDialog = ProgressDialog(context: context);

    try {
      progressDialog.show(
        msgColor: AppColors().white,
        msg: 'Mohon tunggu..',
        barrierDismissible: false,
        backgroundColor: AppColors().primary,
        hideValue: true,
        progressBgColor: Colors.grey[300]!,
        progressValueColor: AppColors().success,
        progressType: ProgressType.valuable,
        completed: Completed(
          completedMsg: 'Selesai!',
        ),
      );

      Response<List<int>> response = await dio.get<List<int>>(
        fileUrl,
        options: Options(responseType: ResponseType.bytes),
        onReceiveProgress: (receivedBytes, totalBytes) {
          double progress = (receivedBytes / totalBytes) * 100;
          progressDialog.update(
            value: int.parse(progress.toStringAsFixed(0)),
            msg: 'Mengunduh video..',
          );
        },
      );

      Uint8List fileData = Uint8List.fromList(response.data!);

      // Save the downloaded file without encryption
      Directory? externalDirectory = await getApplicationDocumentsDirectory();
      String filePath = '${externalDirectory.path}/$fileName';
      await File(filePath).writeAsBytes(fileData);
      print(filePath);

      // Save the downloaded encrypted file
      // await EncryptionHelper().saveEncryptedFile(
      //   context,
      //   fileName: fileName,
      //   fileData: fileData,
      //   encryptionKey: encryptionKey,
      // );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Video berhasil diunduh!',
            style: AppTypographies().caption.copyWith(color: AppColors().white),
          ),
          backgroundColor: AppColors().success,
          duration: const Duration(seconds: 3),
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Video gagal diunduh!',
            style: AppTypographies().caption.copyWith(color: AppColors().white),
          ),
          backgroundColor: AppColors().error,
        ),
      );
    } finally {
      progressDialog.close();
    }
  }

  void deleteFile(context, {required String fileName}) async {
    try {
      // Get the application documents directory
      Directory? externalDirectory = await getApplicationDocumentsDirectory();
      String filePath = '${externalDirectory.path}/$fileName';

      File file = File(filePath);

      // Delete the file if it exists
      if (file.existsSync()) {
        file.deleteSync();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Video berhasil dihapus!',
              style:
                  AppTypographies().caption.copyWith(color: AppColors().white),
            ),
            backgroundColor: AppColors().success,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Video tidak ditemukan!',
              style:
                  AppTypographies().caption.copyWith(color: AppColors().white),
            ),
            backgroundColor: AppColors().error,
          ),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Video gagal dihapus!',
            style: AppTypographies().caption.copyWith(color: AppColors().white),
          ),
          backgroundColor: AppColors().error,
        ),
      );
    }
  }
}
