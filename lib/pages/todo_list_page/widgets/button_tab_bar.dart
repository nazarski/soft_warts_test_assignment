import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soft_warts_test_task/bloc/todo_list_bloc/todo_list_bloc.dart';
import 'package:soft_warts_test_task/pages/todo_list_page/widgets/button_tab_bar_item.dart';
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

  final ButtonStyle _activeButtonStyle = ButtonStyle(
      backgroundColor: const MaterialStatePropertyAll(AppColors.disabled),
      elevation: const MaterialStatePropertyAll(4),
      foregroundColor:
          const MaterialStatePropertyAll(AppColors.secondaryVariant),
      padding:
          const MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 14)),
      textStyle: const MaterialStatePropertyAll(AppStyles.medium18),
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ));
  final ButtonStyle _inactiveButtonStyle = ButtonStyle(
    backgroundColor: const MaterialStatePropertyAll(AppColors.primary),
    foregroundColor: const MaterialStatePropertyAll(AppColors.secondaryVariant),
    padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 14)),
    elevation: const MaterialStatePropertyAll(0),
    textStyle: const MaterialStatePropertyAll(AppStyles.medium18),
    shape: MaterialStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: List.generate(_tabBarValues.length, (index) {
          return ButtonTabBarItem(
              style: _currentIndex == index
                  ? _activeButtonStyle
                  : _inactiveButtonStyle,
              onPressed: _currentIndex == index
                  ? null
                  : () {
                      setState(() {
                        _currentIndex = index;
                      });
                      context.read<TodoListBloc>().add(FilterTodos(index));
                    },
              text: _tabBarValues[index]);
        }),
      ),
    );
  }
}
