import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soft_warts_test_task/bloc/connectivity_bloc/connectivity_bloc.dart';
import 'package:soft_warts_test_task/bloc/manage_single_todo_bloc/manage_single_todo_bloc.dart';
import 'package:soft_warts_test_task/bloc/todo_list_bloc/todo_list_bloc.dart';
import 'package:soft_warts_test_task/constants/strings.dart';
import 'package:soft_warts_test_task/enums/fetch_status.dart';
import 'package:soft_warts_test_task/models/todo_model.dart';
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

class EditTodoPage extends StatefulWidget {
  const EditTodoPage({
    super.key,
    required this.todoToEdit,
  });

  static const routeName = 'edit-todo-page';
  final TodoModel todoToEdit;

  @override
  State<EditTodoPage> createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final hasConnection =
            context.read<ConnectivityBloc>().state.hasConnection;
        return ManageSingleTodoBloc(
          repository: context.read<ManageTodosRepository>(),
          initialTodo: widget.todoToEdit,
        )..add(ChangeHasConnectionFlagSingle(hasConnection));
      },
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
            title: BlocBuilder<ManageSingleTodoBloc, ManageSingleTodoState>(
              buildWhen: (_, __) {
                return false;
              },
              builder: (context, state) {
                return TextField(
                  controller: _nameController..text = state.todo.name,
                  style: AppStyles.semiBold24,
                  cursorColor: AppColors.secondaryVariant,
                  inputFormatters: [LengthLimitingTextInputFormatter(90)],
                  decoration: const InputDecoration(
                    hintText: ConstantStrings.taskName,
                    hintStyle: AppStyles.semiBold24,
                  ),
                );
              },
            ),
            actions: [
              BlocBuilder<ManageSingleTodoBloc, ManageSingleTodoState>(
                builder: (context, state) {
                  return IconButton(
                    splashRadius: 20,
                    onPressed: () {
                      context.read<ManageSingleTodoBloc>().add(UpdateTodo(
                          todoName: _nameController.text,
                          todoDescription: _descriptionController.text));
                    },
                    icon: const Icon(
                      Icons.check,
                      color: AppColors.primaryVariant,
                    ),
                  );
                },
              ),
            ],
          ),
          bottomNavigationBar: BottomAppBar(
            color: AppColors.secondaryVariant,
            child: BlocConsumer<ManageSingleTodoBloc, ManageSingleTodoState>(
              listenWhen: (oldState, newState) {
                return oldState.status != newState.status;
              },
              listener: (context, state) {
                if (state.status == FetchStatus.data) {
                  context.read<TodoListBloc>().add(FilterTodos());
                  Navigator.pop(context);
                }
              },
              buildWhen: (oldState, newState) {
                return oldState.status != newState.status;
              },
              builder: (context, state) {
                return Container(
                  height: 64,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Center(
                    child: AppElevatedButton(
                        onPressed: () {
                          context
                              .read<ManageSingleTodoBloc>()
                              .add(DeleteTodo());
                        },
                        backgroundColor: AppColors.accentRed,
                        child: switch (state.status) {
                          FetchStatus.loading =>
                            const CircularProgressIndicator.adaptive(),
                          FetchStatus.error => const Icon(Icons.error),
                          _ => const Text(
                              ConstantStrings.delete,
                              style: AppStyles.medium24,
                            ),
                        }),
                  ),
                );
              },
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Column(children: [
              const TodoTypeRadioSelector(),
              const SizedBox(
                height: 16,
              ),
              TodoEditorWrap(
                child: BlocBuilder<ManageSingleTodoBloc, ManageSingleTodoState>(
                  buildWhen: (_, __) {
                    return false;
                  },
                  builder: (context, state) {
                    return TextField(
                      controller: _descriptionController
                        ..text = state.todo.description,
                      cursorColor: AppColors.secondaryVariant,
                      style: AppStyles.semiBold18,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        hintText: ConstantStrings.addDescription,
                        hintStyle: AppStyles.semiBold18,
                      ),
                    );
                  },
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
                      text: ConstantStrings.urgent,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 16,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
