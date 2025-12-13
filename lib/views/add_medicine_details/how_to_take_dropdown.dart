import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fakrny/controllers/medicine_controller.dart';
import 'package:fakrny/utils/app_text_styles.dart';
import 'package:fakrny/views/reused_widgets/vertical_space.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HowToTakeDropdown extends StatelessWidget {
  final MedicineController controller;
  const HowToTakeDropdown({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("how_to_take".tr, style: AppTextStyles.smallTextStyle),
        verticalSpace(0.5.h),
        Obx(() => DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            hint: Text("how_to_take".tr, style: AppTextStyles.hintTextStyle),
            value: controller.howToTake.value.isEmpty ? null : controller.howToTake.value,
            items: controller.howToTakeOptions.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: (v) => controller.howToTake.value = v!,
            buttonStyleData: ButtonStyleData(
              height: 6.h,
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xffE0E0E0))),
            ),
          ),
        )),
      ],
    );
  }
}