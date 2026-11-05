import 'package:flutter/material.dart';

/// Shows the ViewModel's error message, or [success] when error is null.
void showResult(BuildContext context, String? error, String success) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(error ?? success)));
}
