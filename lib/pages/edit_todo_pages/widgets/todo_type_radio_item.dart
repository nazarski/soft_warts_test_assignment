import 'package:flutter/material.dart';
import 'package:soft_warts_test_task/core/resources/app_styles.dart';
import 'package:soft_warts_test_task/pages/edit_todo_pages/widgets/custom_radio_button.dart';

class TodoTypeRadioItem extends StatelessWidget {
  const TodoTypeRadioItem({
    super.key,
    required this.radio,
    required this.text,
  });

  final CustomRadioButton radio;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        radio,
        const SizedBox(
          width: 8,
        ),
        Text(
          text,
          style: AppStyles.semiBold18,
        )
      ],
    );
  }
}
