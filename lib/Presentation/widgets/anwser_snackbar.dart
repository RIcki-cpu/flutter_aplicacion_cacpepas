import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, String message, bool isError) {
  final snackBar = SnackBar(
    content: Text(
      message,
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: isError ? Colors.red : Colors.green,
    action: SnackBarAction(
      label: 'Close',
      onPressed: () {
        // Perform any action here when the user presses the action button
      },
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
