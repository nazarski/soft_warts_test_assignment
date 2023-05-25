import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soft_warts_test_task/bloc/connectivity_bloc/connectivity_bloc.dart';
import 'package:soft_warts_test_task/bloc/todo_list_bloc/todo_list_bloc.dart';
import 'package:soft_warts_test_task/enums/fetch_status.dart';
import 'package:soft_warts_test_task/pages/edit_todo_pages/create_todo_page.dart';
import 'package:soft_warts_test_task/pages/todo_list_page/widgets/button_tab_bar.dart';
import 'package:soft_warts_test_task/pages/todo_list_page/widgets/todo_list_builder.dart';
import 'package:soft_warts_test_task/pages/widgets/background_gradient_decoration.dart';
import 'package:soft_warts_test_task/resources/app_colors.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});

  static const routeName = 'todo-list-page';

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectivityBloc, ConnectivityState>(
      listenWhen: (oldState, newState) {
        return oldState.hasConnection != newState.hasConnection;
      },
      listener: (context, state) {
        context
            .read<TodoListBloc>()
            .add(ChangeHasConnectionFlagList(state.hasConnection));
        if(state.hasConnection){
          print('now i have a connection, lets sync');
          context.read<TodoListBloc>().add(SyncTodosAndEmit());
        }
      },
      child: BackgroundGradientDecoration(
        child: SafeArea(
          child: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, CreateTodoPage.routeName);
              },
              backgroundColor: AppColors.primaryVariant,
              foregroundColor: AppColors.secondaryVariant,
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              child: const Icon(
                Icons.add,
                size: 36,
                color: AppColors.secondaryVariant,
              ),
            ),
            backgroundColor: Colors.transparent,
            appBar: const PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: ButtonTabBar(),
            ),
            body: Padding(
              padding: const EdgeInsets.all(18),
              child: BlocBuilder<TodoListBloc, TodoListState>(
                builder: (context, state) {
                  return switch (state.status) {
                    FetchStatus.loading =>
                    const Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                    FetchStatus.error =>
                    const Center(
                      child: Icon(Icons.error),
                    ),
                    _ =>
                        TodoListBuilder(
                          listOfTodos: state.listOfTodos,
                        ),
                  };
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
