import 'dart:io';
import 'dart:typed_data';

import 'package:arkademi_app/config/theme.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class TrafficManager {
  Dio dio = Dio();

  Future<void> downloadFile({
    required String fileUrl,
    required String fileName,
    required context,
  }) async {
    ProgressDialog progressDialog = ProgressDialog(context: context);

    try {
      progressDialog.show();

      Response<List<int>> response = await dio.get<List<int>>(
        fileUrl,
        options: Options(responseType: ResponseType.bytes),
        onReceiveProgress: (receivedBytes, totalBytes) {
          double progress = (receivedBytes / totalBytes) * 100;
          print('progress: ${progress.toStringAsFixed(0)}%');
          print('receivedBytes: $receivedBytes/$totalBytes');

          if (progress == 100) {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          }

          // Show the progress value in the progress dialog
          progressDialog.show(
            barrierDismissible: false,
            elevation: 5,
            msg: 'Mohon tunggu..',
            completed: Completed(
              completedMsg: 'Video berhasil diunduh!',
              completionDelay: 500,
            ),
            msgColor: AppColors().white,
            valueColor: AppColors().white,
            hideValue: true,
            backgroundColor: AppColors().primary,
            progressBgColor: Colors.grey.shade300,
            progressValueColor: AppColors().success,
            progressType: ProgressType.valuable,
          );

          // Update the progress dialog
          progressDialog.update(
            value: int.parse(progress.toStringAsFixed(0)),
            msg: 'Mengunduh video..',
          );
        },
      );
      Uint8List fileData = Uint8List.fromList(response.data!);

      // Get the application documents directory
      Directory appDocumentsDirectory =
          await getApplicationDocumentsDirectory();
      String savePath = '${appDocumentsDirectory.path}/$fileName';

      // Save the data to a file
      File file = File(savePath);
      await file.writeAsBytes(fileData);
      print('File saved at $savePath');

      // Close the progress dialog
      progressDialog.close();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Video berhasil diunduh!',
            style: AppTypographies().caption.copyWith(color: AppColors().white),
          ),
          backgroundColor: AppColors().success,
        ),
      );
    } catch (error) {
      // Close the progress dialog on error
      progressDialog.close();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Video gagal diunduh!',
            style: AppTypographies().caption.copyWith(color: AppColors().white),
          ),
          backgroundColor: AppColors().error,
        ),
      );
    }
  }

  void deleteFile(context, {required String fileName}) async {
    try {
      // Get the application documents directory
      Directory appDocumentsDirectory =
          await getApplicationDocumentsDirectory();
      String filePath = '${appDocumentsDirectory.path}/$fileName';

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
