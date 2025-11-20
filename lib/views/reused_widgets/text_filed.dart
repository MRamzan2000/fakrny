import 'package:fakrny/utils/app_colors.dart';
import 'package:fakrny/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String iconPath;
  final bool isPassword;
  final bool obscureText;
  final VoidCallback? onSuffixTap;
  final Widget? suffixIcon;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.iconPath,
    this.isPassword = false,
    this.obscureText = false,
    this.onSuffixTap,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style:AppTextStyles.hintTextStyle,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.sp),
          borderSide: BorderSide(
              color: AppColors.borderGrey,
            width: 2
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.sp),
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
        isCollapsed: true,
        contentPadding: EdgeInsets.only(left: 3.w,right:  3.w, top: 1.4.h,bottom: 1.4.h),
        /// Prefix Icon
        prefixIcon: SvgPicture.asset(
          iconPath,
          color: const Color(0xff1FB774),
        ),
        prefixIconConstraints:
        BoxConstraints(minHeight: 3.h, minWidth: 12.w),
        /// Suffix Icon (Eye / fingerprint etc.)
        suffixIcon: isPassword
            ? GestureDetector(onTap: onSuffixTap, child: suffixIcon)
            : suffixIcon,
        suffixIconConstraints:
        BoxConstraints(minHeight: 3.h, minWidth: 12.w),

        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 16.sp,
          color: Colors.grey,
        ),
      ),
    );
  }
}
