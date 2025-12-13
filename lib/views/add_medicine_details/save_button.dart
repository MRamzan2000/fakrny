import 'package:fakrny/controllers/medicine_controller.dart';
import 'package:fakrny/views/reused_widgets/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SaveButton extends StatelessWidget {
  final MedicineController controller;
  final String? medicineId;

  const SaveButton({
    super.key,
    required this.controller,
    this.medicineId,
  });

  @override
  Widget build(BuildContext context) {
    final bool isEditMode = medicineId != null;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Obx(() => AbsorbPointer(
        absorbing: controller.isLoading.value,
        child: CustomButton(
          height: 5.5.h,
          title: controller.isLoading.value
              ? "please_wait".tr
              : (isEditMode ? "update".tr : "save".tr),
          onTap: () {

            if (isEditMode) {
              controller.updateMedicine(medicineId!);
            } else {
              controller.addMedicine();
            }
          },
        ),
      )),
    );
  }
}