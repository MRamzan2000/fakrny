import 'package:fakrny/utils/app_colors.dart';
import 'package:fakrny/utils/app_text_styles.dart';
import 'package:fakrny/views/reused_widgets/horizontal_space.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppMessage {
  static void _show({
    required String msg,
    required Color color,
    required IconData icon,
  }) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: color,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        duration: const Duration(seconds: 2),
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            horizontalSpace(2.w),
            Expanded(
              child: Text(
                msg,
                style: AppTextStyles.semiBoldTextStyle.copyWith(
                  color: AppColors.white,
                  fontSize: 17.sp
                )
              ),
            ),
          ],
        ),
      ),
    );
  }

  //  Error (Red)
  static void error(String msg) {
    _show(
      msg: msg,
      color: AppColors.errorColor,
      icon: Icons.error_outline,
    );
  }

  //  Success (Green)
  static void success(String msg) {
    _show(
      msg: msg,
      color:AppColors.primaryColor,
      icon: Icons.check_circle_outline,
    );
  }
}
