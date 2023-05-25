import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soft_warts_test_task/bloc/manage_single_todo_bloc/manage_single_todo_bloc.dart';
import 'package:soft_warts_test_task/core/constants/strings.dart';
import 'package:soft_warts_test_task/core/resources/app_styles.dart';
import 'package:soft_warts_test_task/pages/edit_todo_pages/widgets/todo_editor_wrap.dart';

class AddImageWidget extends StatelessWidget {
  const AddImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<ManageSingleTodoBloc>().add(AddImage());
      },
      child: TodoEditorWrap(
        child: BlocBuilder<ManageSingleTodoBloc, ManageSingleTodoState>(
          buildWhen: (oldState, newState) {
            return newState.todo.file != oldState.todo.file;
          },
          builder: (context, state) {
            if (state.todo.file.isEmpty) {
              return const Text(
                ConstantStrings.addImage,
                style: AppStyles.semiBold18,
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  ConstantStrings.embeddedImage,
                  style: AppStyles.semiBold18,
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Image.memory(
                        base64Decode(state.todo.file),
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                    CloseButton(
                      onPressed: () {
                        context.read<ManageSingleTodoBloc>().add(DeleteImage());
                      },
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
