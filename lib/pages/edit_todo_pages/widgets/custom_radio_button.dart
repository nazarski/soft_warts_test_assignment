import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:soft_warts_test_task/resources/app_colors.dart';

class CustomRadioButton<T> extends StatefulWidget {
  const CustomRadioButton(
      {Key? key,
      required this.type,
      required this.selectedType,
      required this.onTap})
      : super(key: key);
  final T type;
  final T selectedType;
  final ValueChanged<T> onTap;

  @override
  State<CustomRadioButton> createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  bool isSelected = false;

  @override
  void initState() {
    super.initState();

    isSelected = widget.type == widget.selectedType;

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_animationController);

    if (isSelected) {
      _animationController.forward(from: 1);
    }
  }

  @override
  void didUpdateWidget(CustomRadioButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    isSelected = widget.type == widget.selectedType;

    if (isSelected) {
      _animationController.forward(from: 0);
    } else {
      _animationController.reverse(from: 1);
    }
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
          widget.onTap(widget.type);
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (BuildContext context, Widget? child) {
            return Opacity(
              opacity: _fadeAnimation.value,
              child: Container(
                height: 16,
                width: 16,
                decoration: const BoxDecoration(
                  color: AppColors.primaryVariant,
                  shape: BoxShape.circle,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}


