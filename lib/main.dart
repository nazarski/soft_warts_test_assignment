import 'package:flutter/material.dart';
import 'package:soft_warts_test_task/router/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ToDoShechka());
}

class ToDoShechka extends StatelessWidget {
  const ToDoShechka({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
