import 'package:fakrny/controllers/medicine_controller.dart';
import 'package:fakrny/utils/app_colors.dart';
import 'package:fakrny/utils/app_text_styles.dart';
import 'package:fakrny/views/reused_widgets/vertical_space.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class InstructionsField extends StatelessWidget {
  final MedicineController controller;
  const InstructionsField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("special_instructions".tr, style: AppTextStyles.smallTextStyle),
        verticalSpace(0.5.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
          decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.borderGrey)),
          child: TextField(
            controller: controller.instructions,
            maxLines: 4,
            style: AppTextStyles.regularTextStyle,
            decoration: InputDecoration(border: InputBorder.none, hintText: "special_instructions_hint".tr, hintStyle: AppTextStyles.hintTextStyle),
          ),
        ),
      ],
    );
  }
}