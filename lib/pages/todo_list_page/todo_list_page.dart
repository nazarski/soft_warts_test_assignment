import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soft_warts_test_task/bloc/todo_list_bloc/todo_list_bloc.dart';
import 'package:soft_warts_test_task/enums/fetch_status.dart';
import 'package:soft_warts_test_task/pages/todo_list_page/widgets/button_tab_bar.dart';
import 'package:soft_warts_test_task/pages/todo_list_page/widgets/todo_list_builder.dart';
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
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: ButtonTabBar(),
          ),
          body: Padding(
            padding: const EdgeInsets.all(18),
            child: BlocBuilder<TodoListBloc, TodoListState>(
              builder: (context, state) {
                return switch (state.status) {
                  FetchStatus.loading => const Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  FetchStatus.data => TodoListBuilder(
                      listOfTodos: state.listOfTodos,
                    ),
                  FetchStatus.error => const Center(
                      child: Icon(Icons.error),
                    ),
                };
              },
            ),
          ),
        ),
      ),
    );
  }
}

