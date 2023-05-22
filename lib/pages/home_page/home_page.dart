import 'package:flutter/material.dart';
import 'package:soft_warts_test_task/pages/widgets/app_elevated_button.dart';
import 'package:soft_warts_test_task/resources/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const routeName = '/';

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
      child: SafeArea(
        child: Center(
          child: AppElevatedButton(
            onPressed: () {},
            child: const Text('Вхід'),
          ),
        ),
      ),
    );
  }
}
