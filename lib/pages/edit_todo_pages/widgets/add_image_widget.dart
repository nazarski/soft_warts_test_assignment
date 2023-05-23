import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soft_warts_test_task/bloc/manage_single_todo_bloc/manage_single_todo_bloc.dart';
import 'package:soft_warts_test_task/pages/edit_todo_pages/widgets/todo_editor_wrap.dart';
import 'package:soft_warts_test_task/resources/app_styles.dart';

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
            log('image');
            if (state.todo.file.isEmpty) {
              return const Text(
                'Прикріпити зображення',
                style: AppStyles.semiBold18,
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Вкладене зображення',
                  style: AppStyles.semiBold18,
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
                    CloseButton(onPressed: (){
                      context.read<ManageSingleTodoBloc>().add(DeleteImage());
                    },),
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
