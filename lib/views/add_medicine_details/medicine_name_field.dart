import 'package:fakrny/controllers/medicine_controller.dart';
import 'package:fakrny/utils/app_text_styles.dart';
import 'package:fakrny/views/reused_widgets/text_filed.dart';
import 'package:fakrny/views/reused_widgets/vertical_space.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MedicineNameField extends StatelessWidget {
  final MedicineController controller;
  const MedicineNameField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("medicine_name".tr, style: AppTextStyles.smallTextStyle),
        verticalSpace(0.5.h),
        customTextField(
          hintText: "hint_medicine_name".tr,
          controller: controller.name,
          iconPath: "assets/icons/name_medi.svg",
          keyboardType: TextInputType.text,
        ),
      ],
    );
  }
}