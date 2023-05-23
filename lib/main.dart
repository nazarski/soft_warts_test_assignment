import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soft_warts_test_task/bloc/todo_list_bloc/todo_list_bloc.dart';
import 'package:soft_warts_test_task/repositories/manage_todos_repository.dart';
import 'package:soft_warts_test_task/router/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ToDoShechka());
}

class ToDoShechka extends StatelessWidget {
  const ToDoShechka({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ManageTodosRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TodoListBloc(
              context.read<ManageTodosRepository>(),
            )..add(
                GetAllTodos(),
              ),
          ),
        ],
        child: MaterialApp(
          onGenerateRoute: AppRouter.generateRoute,
          theme: ThemeData(
            inputDecorationTheme: InputDecorationTheme(
              border: InputBorder.none,
            )
          ),
        ),
      ),
    );
  }
}
