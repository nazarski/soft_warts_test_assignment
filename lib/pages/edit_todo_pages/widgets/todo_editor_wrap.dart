import 'package:flutter/material.dart';
import 'package:soft_warts_test_task/resources/app_colors.dart';

class TodoEditorWrap extends StatelessWidget {
  const TodoEditorWrap({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 32),
      decoration: const BoxDecoration(color: AppColors.disabled),
      child: child,
    );
  }
}