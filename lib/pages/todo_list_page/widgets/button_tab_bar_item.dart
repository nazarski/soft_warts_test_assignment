import 'package:flutter/material.dart';
import 'package:soft_warts_test_task/core/resources/app_styles.dart';

class ButtonTabBarItem extends StatelessWidget {
  const ButtonTabBarItem({
    super.key,
    required this.onPressed,
    required this.isActive,
    required this.text,
  });

  final VoidCallback onPressed;
  final bool isActive;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: ElevatedButton(
          style: isActive
              ? AppStyles.activeTabButtonStyle
              : AppStyles.inactiveTabButtonStyle,
          onPressed: isActive ? null : onPressed,
          child: Text(text),
        ),
      ),
    );
  }
}
