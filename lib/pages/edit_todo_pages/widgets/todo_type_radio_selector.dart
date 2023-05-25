import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soft_warts_test_task/bloc/manage_single_todo_bloc/manage_single_todo_bloc.dart';
import 'package:soft_warts_test_task/constants/strings.dart';
import 'package:soft_warts_test_task/pages/edit_todo_pages/widgets/custom_radio_button.dart';
import 'package:soft_warts_test_task/pages/edit_todo_pages/widgets/todo_editor_wrap.dart';
import 'package:soft_warts_test_task/pages/edit_todo_pages/widgets/todo_type_radio_item.dart';

class TodoTypeRadioSelector extends StatelessWidget {
  const TodoTypeRadioSelector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageSingleTodoBloc, ManageSingleTodoState>(
      buildWhen: (oldState, newState) {
        return oldState.todo.type != newState.todo.type;
      },
      builder: (context, state) {
        final typeValue = state.todo.type;
        return Column(
          children: [
            TodoEditorWrap(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TodoTypeRadioItem(
                    text: ConstantStrings.work,
                    radio: CustomRadioButton(
                      type: 1,
                      selectedType: typeValue,
                      onTap: (value) {
                        context
                            .read<ManageSingleTodoBloc>()
                            .add(ChangeType(type: value));
                      },
                    ),
                  ),
                  TodoTypeRadioItem(
                    text: ConstantStrings.personal,
                    radio: CustomRadioButton(
                      type: 2,
                      selectedType: typeValue,
                      onTap: (value) {
                        context
                            .read<ManageSingleTodoBloc>()
                            .add(ChangeType(type: value));
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
