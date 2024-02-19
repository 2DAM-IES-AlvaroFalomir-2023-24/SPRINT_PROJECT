import 'package:flutter/material.dart';

class CustomElevatedButtonIconified extends StatelessWidget {
  const CustomElevatedButtonIconified({
    super.key, required this.icon, required this.onPressedFunction, required this.hintText, this.color,
  });

  final Icon icon;
  final Function() onPressedFunction;
  final String hintText;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 75,
        width: 100,
        child: Column(
            children: [
              ElevatedButton(
                onPressed: onPressedFunction,
                style: ButtonStyle(
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Theme.of(context).highlightColor)
                    )),
                    backgroundColor: MaterialStatePropertyAll(color)
                ),
                child: icon,
              ),
              Flexible(child: Text(hintText))
            ]
        )
    );
  }
}