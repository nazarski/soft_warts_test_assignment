import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soft_warts_test_task/bloc/connectivity_bloc/connectivity_bloc.dart';
import 'package:soft_warts_test_task/bloc/todo_list_bloc/todo_list_bloc.dart';
import 'package:soft_warts_test_task/core/constants/strings.dart';
import 'package:soft_warts_test_task/core/enums/fetch_status.dart';
import 'package:soft_warts_test_task/pages/todo_list_page/todo_list_page.dart';
import 'package:soft_warts_test_task/pages/widgets/app_elevated_button.dart';
import 'package:soft_warts_test_task/pages/widgets/background_gradient_decoration.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectivityBloc, ConnectivityState>(
      listener: (context, state) {
        context
            .read<TodoListBloc>()
            .add(ChangeHasConnectionFlagList(state.hasConnection));
      },
      child: BackgroundGradientDecoration(
        child: Center(
          child: BlocConsumer<TodoListBloc, TodoListState>(
            listener: (context, state) {
              if (state.status == FetchStatus.data) {
                Navigator.pushNamedAndRemoveUntil(
                    context, TodoListPage.routeName, (route) => false);
              }
            },
            builder: (context, state) {
              return switch (state.status) {
                FetchStatus.loading =>
                  const CircularProgressIndicator.adaptive(),
                FetchStatus.error => const Icon(Icons.error),
                _ => AppElevatedButton(
                    onPressed: () {
                      context.read<TodoListBloc>().add(SyncTodosAndEmit());
                    },
                    child: const Text(ConstantStrings.enter),
                  )
              };
            },
          ),
        ),
      ),
    );
  }
}
