import 'package:fakrny/controllers/medicine_controller.dart';
import 'package:fakrny/views/add_medicine_details/date_section.dart';
import 'package:fakrny/views/add_medicine_details/dosage_field.dart';
import 'package:fakrny/views/add_medicine_details/dose_stock_row.dart';
import 'package:fakrny/views/add_medicine_details/dose_times_grid.dart';
import 'package:fakrny/views/add_medicine_details/frequency_dropdown.dart';
import 'package:fakrny/views/add_medicine_details/how_to_take_dropdown.dart';
import 'package:fakrny/views/add_medicine_details/instructions_field.dart';
import 'package:fakrny/views/add_medicine_details/medicine_image_picker.dart';
import 'package:fakrny/views/add_medicine_details/medicine_name_field.dart';
import 'package:fakrny/views/add_medicine_details/save_button.dart';
import 'package:fakrny/views/reused_widgets/reused_able_appbar.dart';
import 'package:fakrny/views/reused_widgets/vertical_space.dart';
import 'package:fakrny/views/reused_widgets/voice_sound_alertUI.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddMedicineScreenDetails extends StatelessWidget {
  final String? medicineId;
  AddMedicineScreenDetails({super.key, this.medicineId});

  final controller = Get.put(MedicineController());

  @override
  Widget build(BuildContext context) {
    // Load data on first build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (medicineId != null) {
        controller.loadMedicineForEdit(medicineId!);
      } else {
        controller.clearFormPublic();
      }
    });

    final isEditMode = medicineId != null;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            appBar(title: isEditMode ? "edit_medicine".tr : "add_medicine".tr),
            verticalSpace(2.h),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MedicineImagePicker(controller: controller),
                    verticalSpace(2.h),

                    MedicineNameField(controller: controller),
                    verticalSpace(1.5.h),

                    DosageField(controller: controller),
                    verticalSpace(1.5.h),

                    DoseStockRow(controller: controller),
                    verticalSpace(1.5.h),

                    DateSection(controller: controller),
                    verticalSpace(1.h),

                    FrequencyDropdown(controller: controller),
                    verticalSpace(1.h),

                    DoseTimesGrid(controller: controller),
                    verticalSpace(2.h),

                    HowToTakeDropdown(controller: controller),
                    verticalSpace(2.h),

                    InstructionsField(controller: controller),
                    verticalSpace(2.h),

                    VoiceSoundAlertUI(),
                    verticalSpace(4.h),

                    SaveButton(controller: controller, medicineId: medicineId),
                    verticalSpace(6.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}