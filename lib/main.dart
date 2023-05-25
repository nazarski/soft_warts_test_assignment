import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:soft_warts_test_task/bloc/connectivity_bloc/connectivity_bloc.dart';
import 'package:soft_warts_test_task/bloc/todo_list_bloc/todo_list_bloc.dart';
import 'package:soft_warts_test_task/data/local/isar_db.dart';
import 'package:soft_warts_test_task/models/todo_model.dart';
import 'package:soft_warts_test_task/repositories/manage_todos_repository.dart';
import 'package:soft_warts_test_task/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isar = await initializeIsar();

  runApp(ToDoShechka(
    isar: isar,
  ));
}

class ToDoShechka extends StatelessWidget {
  const ToDoShechka({Key? key, required this.isar}) : super(key: key);
  final Isar isar;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ManageTodosRepository(
        IsarDb(
          isar,
        ),
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ConnectivityBloc()
              ..add(
                ListenToConnectionChanges(),
              ),
          ),
          BlocProvider(
            create: (context) => TodoListBloc(
              context.read<ManageTodosRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          onGenerateRoute: AppRouter.generateRoute,
          theme: ThemeData(
              inputDecorationTheme: const InputDecorationTheme(
            border: InputBorder.none,
          )),
        ),
      ),
    );
  }
}

Future<Isar> initializeIsar() async {
  final dir = await getApplicationDocumentsDirectory();
  return await Isar.open(
    [TodoModelSchema],
    directory: dir.path,
  );
}
