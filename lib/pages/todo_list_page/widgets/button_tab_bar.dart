import 'package:flutter/material.dart';
import 'package:soft_warts_test_task/pages/todo_list_page/todo_list_page.dart';
import 'package:soft_warts_test_task/resources/app_colors.dart';
import 'package:soft_warts_test_task/resources/app_styles.dart';

class ButtonTabBar extends StatefulWidget {
  const ButtonTabBar({
    super.key,
  });

  @override
  State<ButtonTabBar> createState() => _ButtonTabBarState();
}

class _ButtonTabBarState extends State<ButtonTabBar> {
  static const List<String> _tabBarValues = [
    'Усі',
    'Робочі',
    'Особисті',
  ];

  int _currentIndex = 0;

  final ButtonStyle _activeButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.disabled,
    foregroundColor: AppColors.secondaryVariant,
    padding: const EdgeInsets.symmetric(vertical: 14),
    textStyle: AppStyles.medium18,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
  );
  final ButtonStyle _inactiveButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.secondaryVariant,
    padding: const EdgeInsets.symmetric(vertical: 14),
    elevation: 0,
    textStyle: AppStyles.medium18,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
  );


  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(_tabBarValues.length, (index) {
        return ButtonTabBarItem(
            style: _currentIndex == index
                ? _activeButtonStyle
                : _inactiveButtonStyle,
            onPressed: () {
              setState(() {
                _currentIndex = index;
              });
            },
            text: _tabBarValues[index]);
      }),
    );
  }
}