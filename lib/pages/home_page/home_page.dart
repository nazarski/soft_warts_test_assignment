import 'package:flutter/material.dart';
import 'package:soft_warts_test_task/pages/todo_list_page/todo_list_page.dart';
import 'package:soft_warts_test_task/pages/widgets/app_elevated_button.dart';
import 'package:soft_warts_test_task/pages/widgets/background_gradient_decoration.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return BackgroundGradientDecoration(
      child: Center(
        child: AppElevatedButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, TodoListPage.routeName, (route) => false);
          },
          child: const Text('Вхід'),
        ),
      ),
    );
  }
}
