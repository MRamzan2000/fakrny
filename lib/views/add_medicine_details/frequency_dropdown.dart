import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fakrny/controllers/medicine_controller.dart';
import 'package:fakrny/utils/app_text_styles.dart';
import 'package:fakrny/views/reused_widgets/vertical_space.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class FrequencyDropdown extends StatelessWidget {
  final MedicineController controller;
  const FrequencyDropdown({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("dosage_frequency".tr, style: AppTextStyles.smallTextStyle),
        verticalSpace(0.5.h),
        Obx(() => DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            hint: Text("select_frequency".tr, style: AppTextStyles.hintTextStyle),
            value: controller.frequency.value,
            items: controller.frequencyOptions.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
            onChanged: (v) => controller.onFrequencyChanged(v!),
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