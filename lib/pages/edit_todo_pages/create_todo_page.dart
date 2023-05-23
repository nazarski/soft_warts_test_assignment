import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soft_warts_test_task/bloc/manage_single_todo_bloc/manage_single_todo_bloc.dart';
import 'package:soft_warts_test_task/bloc/todo_list_bloc/todo_list_bloc.dart';
import 'package:soft_warts_test_task/enums/fetch_status.dart';
import 'package:soft_warts_test_task/pages/edit_todo_pages/widgets/add_image_widget.dart';
import 'package:soft_warts_test_task/pages/edit_todo_pages/widgets/custom_radio_button.dart';
import 'package:soft_warts_test_task/pages/edit_todo_pages/widgets/finish_date_selector.dart';
import 'package:soft_warts_test_task/pages/edit_todo_pages/widgets/todo_editor_wrap.dart';
import 'package:soft_warts_test_task/pages/edit_todo_pages/widgets/todo_type_radio_item.dart';
import 'package:soft_warts_test_task/pages/edit_todo_pages/widgets/todo_type_radio_selector.dart';
import 'package:soft_warts_test_task/pages/widgets/app_elevated_button.dart';
import 'package:soft_warts_test_task/pages/widgets/background_gradient_decoration.dart';
import 'package:soft_warts_test_task/repositories/manage_todos_repository.dart';
import 'package:soft_warts_test_task/resources/app_colors.dart';
import 'package:soft_warts_test_task/resources/app_styles.dart';
import 'package:image_picker/image_picker.dart';

class CreateTodoPage extends StatefulWidget {
  const CreateTodoPage({Key? key}) : super(key: key);
  static const routeName = 'create-todo-page';

  @override
  State<CreateTodoPage> createState() => _CreateTodoPageState();
}

class _CreateTodoPageState extends State<CreateTodoPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ManageSingleTodoBloc(context.read<ManageTodosRepository>()),
      child: BackgroundGradientDecoration(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              splashRadius: 20,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.primaryVariant,
              ),
            ),
            title: TextField(
              controller: _nameController,
              style: AppStyles.semiBold24,
              cursorColor: AppColors.secondaryVariant,
              decoration: const InputDecoration(
                hintText: 'Назва завдання...',
                hintStyle: AppStyles.semiBold24,
              ),
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Column(children: [
              const TodoTypeRadioSelector(),
              const SizedBox(
                height: 16,
              ),
              TodoEditorWrap(
                child: TextField(
                  controller: _descriptionController,
                  cursorColor: AppColors.secondaryVariant,
                  style: AppStyles.semiBold18,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    hintText: 'Додати опис...',
                    hintStyle: AppStyles.semiBold18,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const AddImageWidget(),
              const SizedBox(
                height: 16,
              ),
              const FinishDateSelector(),
              const SizedBox(
                height: 16,
              ),
              BlocBuilder<ManageSingleTodoBloc, ManageSingleTodoState>(
                buildWhen: (oldState, newState) {
                  return oldState.todo.urgent != newState.todo.urgent;
                },
                builder: (context, state) {
                  final urgent = state.todo.urgent;
                  // print(urgent);
                  return TodoEditorWrap(
                    child: TodoTypeRadioItem(
                      radio: CustomRadioButton(
                        type: true,
                        selectedType: urgent,
                        onTap: (_) {
                          context
                              .read<ManageSingleTodoBloc>()
                              .add(MakeUrgent());
                        },
                      ),
                      text: 'Термінове',
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 16,
              ),
              BlocConsumer<ManageSingleTodoBloc, ManageSingleTodoState>(
                listenWhen: (oldState, newState) {
                  return oldState.status != newState.status;
                },
                listener: (context, state) {
                  if (state.status == FetchStatus.data) {
                    context.read<TodoListBloc>().add(GetAllTodos());
                    Navigator.pop(context);
                  }
                },
                buildWhen: (oldState, newState) {
                  return oldState.todo.finishDate != newState.todo.finishDate ||
                      oldState.status != newState.status;
                },
                builder: (context, state) {
                  return ValueListenableBuilder(
                    valueListenable: _nameController,
                    builder: (BuildContext context, TextEditingValue value,
                        Widget? child) {
                      if (value.text.isNotEmpty &&
                          state.todo.finishDate != null) {
                        return child!;
                      }
                      return const AppElevatedButton(
                        onPressed: null,
                        child: Text('Створити'),
                      );
                    },
                    child: AppElevatedButton(
                      child: switch (state.status) {
                        FetchStatus.error => const Icon(Icons.error),
                        FetchStatus.loading =>
                          const CircularProgressIndicator.adaptive(),
                        _ => const Text('Створити'),
                      },
                      onPressed: () {
                        context.read<ManageSingleTodoBloc>().add(
                              CreateTodo(
                                todoName: _nameController.text,
                                todoDescription: _descriptionController.text,
                              ),
                            );
                      },
                    ),
                  );
                },
              )
            ]),
          ),
        ),
      ),
    );
  }
}
