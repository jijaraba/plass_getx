import 'package:flutter/material.dart';
import 'package:plass_getx/lib/src/core/presentation/res/res.dart';

abstract class PlassSnackbarWidget {
  static SnackBar snackbarError(String text) {
    return SnackBar(
      content: Text(text),
      backgroundColor: UIColors.grey300,
    );
  }

  static SnackBar snackbarInfo(String text) {
    return SnackBar(
      content: Text(text),
    );
  }
}
