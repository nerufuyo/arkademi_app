import 'package:arkademi_app/config/theme.dart';
import 'package:flutter/material.dart';

BottomSheet bottomSheetWidget({
  required void Function() onPrevious,
  required void Function() onNext,
  bool isPreviousDisabled = true,
  bool isNextDisabled = false,
}) {
  return BottomSheet(
    onClosing: () {},
    builder: (context) {
      return SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            2,
            (index) => Expanded(
              child: InkWell(
                onTap: () {},
                splashColor: AppColors().primary.withOpacity(0.75),
                child: Container(
                  color: AppColors().white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: index == 0,
                        child: Icon(
                          Icons.keyboard_double_arrow_left_rounded,
                          color:
                              isPreviousDisabled ? Colors.grey : Colors.black,
                        ),
                      ),
                      Text(
                        index == 0 ? 'Sebelumnya' : 'Selanjutnya',
                        style: AppTypographies().button.copyWith(
                              color: isPreviousDisabled
                                  ? index == 0
                                      ? Colors.grey
                                      : Colors.black
                                  : isNextDisabled
                                      ? index == 0
                                          ? Colors.black
                                          : Colors.grey
                                      : Colors.black,
                            ),
                      ),
                      Visibility(
                        visible: index == 1,
                        child: Icon(
                          Icons.keyboard_double_arrow_right_rounded,
                          color: isNextDisabled ? Colors.grey : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
