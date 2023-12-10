import 'package:flutter/material.dart';

Widget loadingWidget() {
  return const Center(
    child: CircularProgressIndicator(),
  );
}

Widget emptyWidget() {
  return const Center(
    child: Text('Data Not Found'),
  );
}

Widget errorWidget(state) {
  return Center(
    child: Text(state.message),
  );
}
