import 'package:flutter/material.dart';
import 'package:soft_warts_test_task/core/resources/app_colors.dart';

class BackgroundGradientDecoration extends StatelessWidget {
  const BackgroundGradientDecoration({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.secondary,
            AppColors.secondaryVariant,
          ],
        ),
      ),
      child: child,
    );
  }
}
