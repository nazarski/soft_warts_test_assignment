import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soft_warts_test_task/bloc/todo_list_bloc/todo_list_bloc.dart';
import 'package:soft_warts_test_task/core/resources/app_colors.dart';
import 'package:soft_warts_test_task/core/resources/app_styles.dart';
import 'package:soft_warts_test_task/core/utils/date_helper.dart';
import 'package:soft_warts_test_task/models/todo_model.dart';
import 'package:soft_warts_test_task/pages/edit_todo_pages/edit_todo_page.dart';

class TodoListBuilder extends StatelessWidget {
  const TodoListBuilder({
    super.key,
    required this.listOfTodos,
  });

  final List<TodoModel> listOfTodos;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(top: 16),
      itemBuilder: (context, index) {
        final todo = listOfTodos[index];
        final finishDate = formatDateOrNow(todo.finishDate);
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              EditTodoPage.routeName,
              arguments: todo,
            );
          },
          child: Container(
            height: 64,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: todo.urgent ? AppColors.accentRed : AppColors.primary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                switch (todo.type) {
                  2 => const Icon(Icons.home_outlined),
                  _ => const Icon(Icons.work_outline),
                },
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            todo.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyles.semiBold16,
                          ),
                        ),
                      ),
                      Text(
                        finishDate,
                        style: AppStyles.semiBold11,
                      ),
                    ],
                  ),
                ),
                Transform.scale(
                  scale: 1.8,
                  child: Checkbox(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    checkColor: AppColors.secondaryVariant,
                    fillColor:
                        const MaterialStatePropertyAll(AppColors.disabled),
                    side: MaterialStateBorderSide.resolveWith(
                      (states) =>
                          const BorderSide(color: AppColors.secondaryVariant),
                    ),
                    value: todo.completed,
                    onChanged: (bool? value) {
                      context.read<TodoListBloc>().add(
                            UpdateTodoCheckbox(
                              todo,
                              value!,
                            ),
                          );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (_, __) => const SizedBox(
        height: 5,
      ),
      itemCount: listOfTodos.length,
    );
  }
}
