import 'package:fakrny/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomRadio extends StatelessWidget {
  final bool isSelected;
  final Function() onTap;

  const CustomRadio({
    super.key,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 4.5.w,
        height: 4.5.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : Colors.grey,
            width: 4.sp,
          ),
        ),
        child: isSelected
            ? Center(
          child: Container(
            width: 2.5.w,
            height: 2.5.w,
            decoration:  BoxDecoration(
              color:  AppColors.primaryColor,
              shape: BoxShape.circle,
            ),
          ),
        )
            : const SizedBox(),
      ),
    );
  }
}
