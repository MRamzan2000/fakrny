import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'app_colors.dart';

class AppTextStyles {
  static TextStyle specialBoldTextStyle = TextStyle(
      fontFamily: "SfPro",
      fontSize: 56.sp,
      fontWeight: FontWeight.bold,
      color: AppColors.buttonText);

  static TextStyle boldTextStyle = TextStyle(
      fontFamily: "SfPro",
      fontSize: 26.sp,
      fontWeight: FontWeight.bold,
      color: AppColors.white);

  static TextStyle greenBoldTextStyle = TextStyle(
      fontFamily: "SfPro",
      fontSize: 28.sp,
      fontWeight: FontWeight.bold,
      color: AppColors.primaryColor);

  static TextStyle semiBoldTextStyle = TextStyle(
      fontFamily: "SfPro",
      fontSize: 20.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.white);

  static TextStyle buttonTextStyle = TextStyle(
      fontFamily: "SfPro",
      fontSize: 19.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.buttonText);

  static TextStyle regularTextStyle = TextStyle(
      fontFamily: "SfPro",
      fontSize: 19.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.buttonText);

  static TextStyle smallTextStyle = TextStyle(
      fontFamily: "SfPro",
      fontSize: 18.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.buttonText);

  static TextStyle hintTextStyle = TextStyle(
      fontFamily: "poppins",
      fontSize: 18.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.borderGrey);

  static TextStyle primaryTextStyle = TextStyle(
      fontFamily: "poppins",
      fontSize: 18.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.primaryColor);
}