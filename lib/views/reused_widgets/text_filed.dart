import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fakrny/utils/app_colors.dart';
import 'package:fakrny/utils/app_text_styles.dart';
import 'package:fakrny/views/reused_widgets/horizontal_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomInputField extends StatelessWidget {
  // Common
  final String hintText;
  final String prefixIconPath;
  final Widget? child;

  // TextField specific
  final TextEditingController? controller;
  final bool isPassword;
  final int? maxLine;
  final bool obscureText;
  final VoidCallback? onSuffixTap;
  final Widget? suffixIcon;

  // DatePicker / Dropdown specific
  final Widget? trailingIcon;
  final VoidCallback? onTap;

  const CustomInputField({
    super.key,
    required this.hintText,
    required this.prefixIconPath,
    this.child,
    this.controller,
    this.isPassword = false,
    this.obscureText = false,
    this.onSuffixTap,
    this.suffixIcon,
    this.trailingIcon,
    this.onTap,
    this.maxLine,
  });

  @override
  Widget build(BuildContext context) {
    final isArabic = Get.locale?.languageCode == "ar";

    return GestureDetector(
      onTap: onTap,
      child: Focus(
        child: Builder(
          builder: (context) {
            final isFocused = Focus.of(context).hasFocus;

            return Container(
              height: 6.h,
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(14.sp),
                border: Border.all(
                  color: isFocused ? AppColors.primaryColor : AppColors.borderGrey,
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    prefixIconPath,
                    height: 3.2.h,
                    color: AppColors.primaryColor,
                  ),
                  horizontalSpace(3.w),

                  // Main input widget
                  Expanded(
                    child: child ??
                        Directionality(
                          textDirection:
                          isArabic ? TextDirection.rtl : TextDirection.ltr,
                          child: TextField(
                            cursorColor: AppColors.primaryColor,
                            cursorHeight: 2.5.h,
                            controller: controller,
                            obscureText: obscureText,
                            maxLines: maxLine ?? 1,
                            style: AppTextStyles.regularTextStyle.copyWith(
                              fontSize: 16.5.sp,
                              color: Colors.black,
                            ),
                            textDirection:
                            isArabic ? TextDirection.rtl : TextDirection.ltr,
                            textAlign:
                            isArabic ? TextAlign.right : TextAlign.left,
                            decoration: InputDecoration(
                              isCollapsed: true,
                              border: InputBorder.none,
                              hintText: hintText,
                              hintStyle: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                  ),

                  // Trailing Icon (Chevron for dropdown/date, Eye for password)
                  if (trailingIcon != null || (isPassword && suffixIcon != null))
                    Padding(
                      padding: EdgeInsets.only(left: 2.w),
                      child: trailingIcon ??
                          GestureDetector(
                            onTap: onSuffixTap,
                            child: suffixIcon,
                          ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Custom TextField
Widget customTextField({
  required String hintText,
  int? maxLine,
  required TextEditingController controller,
  required String iconPath,
  bool isPassword = false,
  bool obscureText = false,
  VoidCallback? onSuffixTap,
  Widget? suffixIcon,
}) {
  return CustomInputField(
    hintText: hintText,
    prefixIconPath: iconPath,
    controller: controller,
    isPassword: isPassword,
    obscureText: obscureText,
    onSuffixTap: onSuffixTap,
    suffixIcon: suffixIcon,
    maxLine: maxLine,
  );
}

/// Custom Dropdown
Widget customDropdownField<T>({
  required String hint,
  int? maxLine,
  required Rx<T?> selectedValue,
  required List<T> items,
  required String Function(T) label,
  required String prefixPath,
}) {
  return CustomInputField(
    hintText: hint,
    maxLine: maxLine,
    prefixIconPath: prefixPath,
    trailingIcon: SvgPicture.asset(
      "assets/icons/down_arrow.svg",
      height: 1.h,
      color: AppColors.primaryColor,
    ),
    child: DropdownButtonHideUnderline(
      child: DropdownButton2<T>(
        isExpanded: true,
        customButton: Text(
          selectedValue.value == null ? hint : label(selectedValue.value as T),
          style: TextStyle(
            fontSize: 16.sp,
            color: selectedValue.value == null ? Colors.grey : Colors.black,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        value: selectedValue.value,
        onChanged: (v) => selectedValue.value = v,
        items: items.map((e) {
          return DropdownMenuItem<T>(
            value: e,
            child: Text(
              label(e),
              style: TextStyle(fontSize: 16.sp, color: Colors.black),
            ),
          );
        }).toList(),
        dropdownStyleData: DropdownStyleData(
          padding: EdgeInsets.zero,
          maxHeight: 35.h,
          width: MediaQuery.of(Get.context!).size.width * 0.4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.sp),
            color: AppColors.white,
          ),
          offset: const Offset(0, -8),
        ),
        alignment: Alignment.bottomCenter,
      ),
    ),
  );
}

/// DOB Picker
Widget dobPicker({
  required Rx<DateTime?> selectedDate,
  String hintText = "01-Jan-1990",
  String prefixSvgPath = "assets/icons/calendar.svg",
}) {
  return CustomInputField(
    hintText: hintText,
    prefixIconPath: prefixSvgPath,
    onTap: () async {
      final picked = await showDatePicker(
        context: Get.context!,
        initialDate: selectedDate.value ?? DateTime(1990),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
        builder: (context, child) => Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: AppColors.primaryColor),
          ),
          child: child!,
        ),
      );
      if (picked != null) selectedDate.value = picked;
    },
    child: Obx(() => Text(
      selectedDate.value == null
          ? hintText
          : DateFormat('dd-MMM-yyyy').format(selectedDate.value!),
      style: TextStyle(
        fontSize: 16.sp,
        color: selectedDate.value == null ? Colors.grey : Colors.black,
      ),
    )),
  );
}
