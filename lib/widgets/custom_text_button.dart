import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Function() onPressed;
  const CustomTextButton({super.key, required this.text, required this.style, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Text(
        text,
        style: style,
      ),
    );
  }
}