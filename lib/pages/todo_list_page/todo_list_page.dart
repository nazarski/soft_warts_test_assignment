import 'package:flutter/material.dart';
import 'package:soft_warts_test_task/pages/todo_list_page/widgets/button_tab_bar.dart';
import 'package:soft_warts_test_task/pages/widgets/background_gradient_decoration.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});

  static const routeName = 'todo-list-page';

  @override
  Widget build(BuildContext context) {
    return BackgroundGradientDecoration(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                const ButtonTabBar(),
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return Container(
                        color: Colors.red,
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(
                      height: 5,
                    ),
                    itemCount: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



