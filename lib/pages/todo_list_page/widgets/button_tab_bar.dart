import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soft_warts_test_task/bloc/todo_list_bloc/todo_list_bloc.dart';
import 'package:soft_warts_test_task/core/constants/strings.dart';
import 'package:soft_warts_test_task/pages/todo_list_page/widgets/button_tab_bar_item.dart';

class ButtonTabBar extends StatefulWidget {
  const ButtonTabBar({
    super.key,
  });

  @override
  State<ButtonTabBar> createState() => _ButtonTabBarState();
}

class _ButtonTabBarState extends State<ButtonTabBar> {
  static const List<String> _tabBarValues = [
    ConstantStrings.all,
    ConstantStrings.work,
    ConstantStrings.personal,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoListBloc, TodoListState>(
      buildWhen: (oldState, newState) {
        return oldState.listFilterIndex != newState.listFilterIndex;
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: List.generate(_tabBarValues.length, (index) {
              final bool isActive = state.listFilterIndex == index;
              return ButtonTabBarItem(
                text: _tabBarValues[index],
                isActive: isActive,
                onPressed: () {
                  context.read<TodoListBloc>().add(
                        FilterTodos(todoType: index),
                      );
                },
              );
            }),
          ),
        );
      },
    );
  }
}
