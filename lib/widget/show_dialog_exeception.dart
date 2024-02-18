import 'package:flutter/material.dart';

class MyDialogExeception {
  final String message;

  MyDialogExeception({required this.message});

  Future<void> showDialogWithDelay(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
            content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Aceptar'),
            ),
          ],
        ),
      );
    });
  }
}
