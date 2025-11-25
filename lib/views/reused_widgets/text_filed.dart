// custom_input_field.dart
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fakrny/utils/app_colors.dart';
import 'package:fakrny/utils/app_text_styles.dart';
import 'package:fakrny/views/reused_widgets/horizontal_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomInputField extends StatelessWidget {
  // Common
  final String hintText;
  final String prefixIconPath;
  final Widget? child;

  // TextField specific
  final TextEditingController? controller;
  final bool isPassword;
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
  });

  // Shared decoration
  BoxDecoration get _decoration => BoxDecoration(
    color: AppColors.white,
    borderRadius: BorderRadius.circular(14.sp),
    border: Border.all(color: AppColors.borderGrey,),
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 6.h,
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        decoration: _decoration,
        child: Row(
          children: [
            // Prefix Icon
            SvgPicture.asset(
              prefixIconPath,
              height: 3.2.h,
              color: const Color(0xff1FB774),
            ),
            horizontalSpace(3.w),
            Expanded(
              child: child ??
                  TextField(
                    controller: controller,
                    obscureText: obscureText,
                    style: AppTextStyles.hintTextStyle,
                    decoration: InputDecoration(
                      isCollapsed: true,
                      border: InputBorder.none,
                      hintText: hintText,
                      hintStyle: TextStyle(fontSize: 16.sp, color: Colors.grey),
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
      ),
    );
  }
}

// custom_text_field.dart
Widget customTextField({
  required String hintText,
  required TextEditingController controller,
  required String iconPath,
  bool isPassword = false,
  bool obscureText = false,
  VoidCallback? onSuffixTap,
  Widget? suffixIcon,
})
{
  return CustomInputField(
    hintText: hintText,
    prefixIconPath: iconPath,
    controller: controller,
    isPassword: isPassword,
    obscureText: obscureText,
    onSuffixTap: onSuffixTap,
    suffixIcon: suffixIcon,
  );
}


Widget customDropdownField<T>({
  required String hint,
  required Rx<T?> selectedValue,
  required List<T> items,
  required String Function(T) label,
  required String prefixPath,
}) {
  return CustomInputField(
    hintText: hint,
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
            border: Border.all(color: AppColors.borderGrey, width: 2),
            color: AppColors.white,
          ),
          offset: const Offset(0, -8),
        ),
        alignment: Alignment.bottomCenter,
      ),
    ),
  );
}
// dob_picker.dart
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
      style: TextStyle(fontSize: 16.sp, color: Colors.grey),
    )),
  );
}