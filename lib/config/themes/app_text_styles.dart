import 'package:final_project/config/themes/app_colors.dart';
import 'package:final_project/config/themes/app_fonts.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  static const heading32Bold = TextStyle(
      fontFamily: FontFamily.montserrat,
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: AppColors.white);
  static const heading20 = TextStyle(
      fontFamily: FontFamily.montserrat, fontSize: 20, color: AppColors.white);
  static const heading18 = TextStyle(
    fontFamily: FontFamily.montserrat,
    fontSize: 18,
    color: AppColors.white,
  );
  static const normal16 = TextStyle(
    color: AppColors.white,
    fontSize: 16,
  );
  static const normal15 = TextStyle(
    color: AppColors.white,
    fontSize: 15,
  );
  static const hint15 = TextStyle(
    color: Colors.white54,
    fontSize: 15,
  );
}
