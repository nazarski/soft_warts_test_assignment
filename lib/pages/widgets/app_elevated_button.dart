import 'package:flutter/material.dart';
import 'package:soft_warts_test_task/resources/app_colors.dart';
import 'package:soft_warts_test_task/resources/app_styles.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    super.key,
    this.backgroundColor,
    required this.child,
    required this.onPressed,
  });

  final Color? backgroundColor;
  final Widget child;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.secondaryVariant,
        backgroundColor: backgroundColor ?? AppColors.primaryVariant,
        textStyle: AppStyles.medium24,
        padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
