import 'package:arkademi_app/config/theme.dart';
import 'package:flutter/material.dart';

dialogWidget(
  context, {
  required String message,
  required String action,
  required void Function() onTapped,
}) {
  return showDialog(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: AppColors().white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        height: MediaQuery.sizeOf(context).height * .275,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox.shrink(),
            Text(
              message,
              style: AppTypographies().subtitle1,
              textAlign: TextAlign.center,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                2,
                (index) => ElevatedButton(
                  onPressed: () {
                    index == 0 ? Navigator.pop(context) : onTapped();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: index == 1 ? AppColors().error : null,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: index == 0
                            ? AppColors().primary
                            : AppColors().error,
                      ),
                    ),
                    fixedSize: Size(
                      MediaQuery.sizeOf(context).width / 3,
                      16,
                    ),
                  ),
                  child: Text(
                    index == 0 ? 'Batal' : action,
                    style: AppTypographies().button.copyWith(
                          color: index == 0
                              ? AppColors().primary
                              : AppColors().white,
                        ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
