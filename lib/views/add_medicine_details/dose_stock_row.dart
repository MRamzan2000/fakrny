import 'package:fakrny/controllers/medicine_controller.dart';
import 'package:fakrny/utils/app_text_styles.dart';
import 'package:fakrny/views/reused_widgets/horizontal_space.dart';
import 'package:fakrny/views/reused_widgets/text_filed.dart';
import 'package:fakrny/views/reused_widgets/vertical_space.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DoseStockRow extends StatelessWidget {
  final MedicineController controller;
  const DoseStockRow({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("medicine_dose".tr, style: AppTextStyles.smallTextStyle),
              verticalSpace(0.5.h),
              customTextField(
                hintText: "hint_dose".tr,
                controller: controller.dose,
                iconPath: "assets/icons/dose_medi.svg",
                keyboardType: TextInputType.text,
              ),
            ],
          ),
        ),
        horizontalSpace(2.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("medicine_stock".tr, style: AppTextStyles.smallTextStyle),
              verticalSpace(0.5.h),
              customTextField(
                hintText: "hint_stock".tr,
                controller: controller.stock,
                iconPath: "assets/icons/stock_medi.svg",
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
      ],
    );
  }
}