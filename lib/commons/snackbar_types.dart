import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class SnackBarTypes {
  static SnackBar createFailedSnackbar(String message) => SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Error',
          message: message,
          contentType: ContentType.failure,
        ),
      );
  static SnackBar createSuccessSnackbar(String message) => SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Success',
          message: message,
          contentType: ContentType.success,
        ),
      );
}
