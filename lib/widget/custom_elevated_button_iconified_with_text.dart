import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sprint/app_localizations.dart';
import 'package:sprint/bloc/social_sign_and_login.dart';
import 'package:sprint/screens/home_screen.dart';

class CustomElevatedButtonIconifiedWithText extends StatelessWidget {
  const CustomElevatedButtonIconifiedWithText({
    super.key, required this.onPressedFunction, required this.text, required this.icon,
  });

  final Function() onPressedFunction;
  final String text;
  final Image icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressedFunction,
        style: ButtonStyle(
          shape: MaterialStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(color: Theme.of(context).highlightColor)
          )),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(right:8.0),
              child: icon,
            ),
            Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: Text(text),
            )
          ],
        )
    );
  }
}