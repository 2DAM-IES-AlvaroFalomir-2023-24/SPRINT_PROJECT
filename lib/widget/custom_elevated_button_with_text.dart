import 'package:flutter/material.dart';

class CustomElevatedButtonWithText extends StatelessWidget {
  const CustomElevatedButtonWithText({
    super.key, required this.text, required this.onPressedFunction,
  });

  final String text;
  final Function() onPressedFunction;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressedFunction,
        style: ButtonStyle(
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: BorderSide(color: Theme.of(context).highlightColor)
            ))
        ),
        child: Text(text, style: const TextStyle(fontSize: 18))
    );
  }
}