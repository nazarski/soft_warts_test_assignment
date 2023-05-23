import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:soft_warts_test_task/bloc/manage_single_todo_bloc/manage_single_todo_bloc.dart';
import 'package:soft_warts_test_task/pages/edit_todo_pages/widgets/todo_editor_wrap.dart';
import 'package:soft_warts_test_task/resources/app_styles.dart';

class FinishDateSelector extends StatefulWidget {
  const FinishDateSelector({Key? key}) : super(key: key);

  @override
  State<FinishDateSelector> createState() => _FinishDateSelectorState();
}

class _FinishDateSelectorState extends State<FinishDateSelector> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final dateNow = DateTime.now();
        final newDate = await showDatePicker(
          context: context,
          initialDate: dateNow,
          firstDate: dateNow,
          lastDate: dateNow.add(
            const Duration(
              days: 30,
            ),
          ),
          helpText: 'Коли плануєте завершити?',
        );
        if (newDate != null && mounted) {
          context.read<ManageSingleTodoBloc>().add(SelectFinishDate(newDate));
        }
      },
      child: TodoEditorWrap(
        child: Row(
          children: [
            const Text(
              'Дата завершення:',
              style: AppStyles.semiBold18,
            ),
            const SizedBox(
              width: 8,
            ),
            BlocBuilder<ManageSingleTodoBloc, ManageSingleTodoState>(
                buildWhen: (oldState, newState) {
              return oldState.todo.finishDate != newState.todo.finishDate;
            }, builder: (context, state) {
              final finishDate = state.todo.finishDate != null
                  ? DateFormat('dd MMMM yyyy').format(
                      state.todo.finishDate!,
                    )
                  : '';
              return Text(
                finishDate,
                style: AppStyles.semiBold18,
              );
            })
          ],
        ),
      ),
    );
  }
}
