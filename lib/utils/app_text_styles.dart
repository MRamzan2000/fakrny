import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'app_colors.dart';

class AppTextStyles{
  static TextStyle specialBoldTextStyle=TextStyle(
      fontFamily: "SfPro",
      fontSize: 48.sp,
      fontWeight: FontWeight.bold,
      color: AppColors.buttonText
  );
  static TextStyle boldTextStyle=TextStyle(
      fontFamily: "SfPro",
      fontSize: 22.sp,
      fontWeight: FontWeight.bold,
      color: AppColors.white
  );
  static TextStyle greenBoldTextStyle=TextStyle(
      fontFamily: "SfPro",
      fontSize: 22.sp,
      fontWeight: FontWeight.bold,
      color: AppColors.white
  );
  static TextStyle semiBoldTextStyle=TextStyle(
      fontFamily: "SfPro",
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.white
  );
  static TextStyle buttonTextStyle=TextStyle(
      fontFamily: "SfPro",
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.buttonText
  );
  static TextStyle regularTextStyle=TextStyle(
      fontFamily: "SfPro",
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.buttonText
  );
  static TextStyle smallTextStyle=TextStyle(
      fontFamily: "SfPro",
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.buttonText
  );
  static TextStyle hintTextStyle=TextStyle(
      fontFamily: "poppins",
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.borderGrey
  );
  static TextStyle primaryTextStyle=TextStyle(
      fontFamily: "poppins",
      fontSize: 13.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.primaryColor
  );
}