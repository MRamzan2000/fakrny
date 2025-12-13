import 'package:fakrny/utils/app_colors.dart';
import 'package:fakrny/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

PreferredSizeWidget appBar({
  required String title,
Function()? onTap
}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(6.h),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      width: double.infinity,
      color: AppColors.appBarColor,
      child: Row(
        children: [
          /// BACK BUTTON
          GestureDetector(
            onTap: () => Get.back(),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 3.h,
              color: AppColors.textColor,
            ),
          ),

          /// CENTER TITLE
          Expanded(
            child: GestureDetector(
              onTap:onTap ,
                child:
            Center(
              child: Text(
                title,
                style: AppTextStyles.boldTextStyle.copyWith(
                  color: AppColors.textColor,
                  fontSize: 19.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),)
          ),

          /// RIGHT SPACER TO BALANCE LAYOUT
          SizedBox(width: 3.h),
        ],
      ),
    ),
  );
}
