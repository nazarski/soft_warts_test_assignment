import 'package:flutter/material.dart';
import 'package:soft_warts_test_task/resources/app_colors.dart';

class AppStyles {
  AppStyles._();

  static const TextStyle medium18 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle medium24 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle semiBold11 = TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w600,
      color: AppColors.secondaryVariant);
  static const TextStyle semiBold16 = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColors.secondaryVariant);
  static const TextStyle semiBold18 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle semiBold24 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );
}
