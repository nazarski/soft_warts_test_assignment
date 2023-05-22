import 'package:flutter/material.dart';

class ButtonTabBarItem extends StatelessWidget {
  const ButtonTabBarItem({
    super.key,
    required this.style,
    required this.onPressed,
    required this.text,
  });

  final ButtonStyle style;
  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: ElevatedButton(
          style: style,
          onPressed: onPressed,
          child: Text(text),
        ),
      ),
    );
  }
}
