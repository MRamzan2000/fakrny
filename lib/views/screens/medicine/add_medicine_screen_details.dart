import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fakrny/controllers/medicine_controller.dart';
import 'package:fakrny/views/reused_widgets/elevated_button.dart';
import 'package:fakrny/views/reused_widgets/voice_sound_alertUI.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:fakrny/utils/app_colors.dart';
import 'package:fakrny/utils/app_text_styles.dart';
import 'package:fakrny/views/reused_widgets/text_filed.dart';
import 'package:fakrny/views/reused_widgets/reused_able_appbar.dart';
import 'package:fakrny/views/reused_widgets/vertical_space.dart';
import 'package:fakrny/views/reused_widgets/horizontal_space.dart';

class AddMedicineScreenDetails extends StatelessWidget {
  AddMedicineScreenDetails({super.key});
  final controller = Get.put(AddMedicineController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: 100.w,
          height: 100.h,
          child: Column(
            children: [
              appBar(title: "add_medicine".tr),
              verticalSpace(2.h),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildMedicinePictureSection(),
                      verticalSpace(2.h),

                      _buildLabeledField("medicine_name".tr, _buildTextField(controller.name, "hint_medicine_name".tr, "assets/icons/name_medi.svg")),
                      verticalSpace(1.5.h),

                      _buildLabeledField("medicine_dosage".tr, _buildTextField(controller.dosage, "hint_dosage".tr, "assets/icons/dosage_medi.svg")),
                      verticalSpace(1.5.h),

                      Row(
                        children: [
                          Expanded(child: _buildLabeledField("medicine_dose".tr, _buildTextField(controller.dose, "hint_dose".tr, "assets/icons/dose_medi.svg"))),
                          horizontalSpace(2.w),
                          Expanded(child: _buildLabeledField("medicine_stock".tr, _buildTextField(controller.stock, "hint_stock".tr, "assets/icons/stock_medi.svg"))),
                        ],
                      ),
                      verticalSpace(1.5.h),

                      Text("dosage_frequency_time".tr, style: AppTextStyles.smallTextStyle),
                      verticalSpace(1.h),

                      Row(
                        children: [
                          Expanded(child: _buildDateField("start_date".tr, controller.startDate)),
                          horizontalSpace(2.w),
                          Expanded(child: _buildDateField("end_date".tr, controller.endDate)),
                        ],
                      ),
                      verticalSpace(1.h),

                      _buildDropdown(controller.frequency, controller.frequencyOptions, "dosage_frequency".tr),
                      verticalSpace(1.h),

                      _buildDoseTimeRow(),
                      verticalSpace(2.h),

                      _buildDropdown(controller.howToTake, controller.howToTakeOptions, "how_to_take".tr),
                      verticalSpace(1.h),

                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 3.w),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(14.sp),
                          border: Border.all(color: AppColors.borderGrey),
                        ),
                        child: TextField(
                          maxLines: 5,
                          style: AppTextStyles.hintTextStyle,
                          decoration: InputDecoration(
                            isCollapsed: true,
                            border: InputBorder.none,
                            hintText: "special_instructions".tr,
                            hintStyle: TextStyle(fontSize: 16.sp, color: Colors.grey),
                          ),
                        ),
                      ),
                      verticalSpace(1.5.h),

                      VoiceSoundAlertUI(),
                      verticalSpace(4.h),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: CustomButton(
                          height: 5.5.h,
                          title: "save".tr,
                          onTap: () => _onSave(),
                        ),
                      ),

                      verticalSpace(4.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Medicine Picture Section
  Widget _buildMedicinePictureSection() => GestureDetector(
    onTap: _showImagePickerPopup,
    child: Obx(() => Container(
      width: double.infinity,
      padding: controller.selectedImagePath.value != null
          ? EdgeInsets.zero
          : EdgeInsets.symmetric(vertical: 4.h, horizontal: 26.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xff999999), width: 1.5),
      ),
      child: controller.selectedImagePath.value != null
          ? Image.file(File(controller.selectedImagePath.value!))
          : Column(
        children: [
          SizedBox(height: 12.h, width: 12.h, child: SvgPicture.asset("assets/icons/image_pic.svg")),
          verticalSpace(1.5.h),
          Text(
            "add_medicine_picture".tr,
            style: AppTextStyles.hintTextStyle.copyWith(color: const Color(0xff999999), fontSize: 16.sp),
          ),
        ],
      ),
    )),
  );

  void _showImagePickerPopup() {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xff1FB774), Color(0xff63E4AE)], begin: Alignment.centerLeft, end: Alignment.centerRight),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(22), topRight: Radius.circular(22)),
        ),
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt, size: 4.h, color: AppColors.white),
              title: Text("take_photo".tr, style: AppTextStyles.regularTextStyle.copyWith(color: AppColors.white, fontSize: 17.sp, fontWeight: FontWeight.w500)),
              onTap: () {
                controller.pickFromCamera();
                Get.back();
              },
            ),
            ListTile(
              leading: Icon(Icons.photo, size: 4.h, color: AppColors.white),
              title: Text("choose_from_gallery".tr, style: AppTextStyles.regularTextStyle.copyWith(color: AppColors.white, fontSize: 17.sp, fontWeight: FontWeight.w500)),
              onTap: () {
                controller.pickFromGallery();
                Get.back();
              },
            ),
            ListTile(
              leading: Icon(Icons.close, size: 3.4.h, color: AppColors.white),
              title: Text("cancel".tr, style: AppTextStyles.regularTextStyle.copyWith(color: AppColors.white, fontSize: 17.sp, fontWeight: FontWeight.w500)),
              onTap: () => Get.back(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabeledField(String label, Widget field) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      label.isEmpty ? const SizedBox.shrink() : Text(label, style: AppTextStyles.smallTextStyle),
      verticalSpace(0.4.h),
      field,
    ],
  );

  Widget _buildTextField(TextEditingController ctrl, String hint, String iconPath) =>
      customTextField(hintText: hint, controller: ctrl, iconPath: iconPath);

  Widget _buildDateField(String label, Rx<DateTime> date) => Obx(() => GestureDetector(
    onTap: () async {
      DateTime? selected = await showDatePicker(
        context: Get.context!,
        initialDate: date.value.isBefore(DateTime.now()) ? DateTime.now() : date.value,
        firstDate: DateTime.now(),
        lastDate: DateTime(2030),
        builder: (context, child) => Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: AppColors.primaryColor, onPrimary: Colors.white, onSurface: AppColors.textColor),
            textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: AppColors.primaryColor)),
          ),
          child: child!,
        ),
      );
      if (selected != null) date.value = selected;
    },
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.2.h),
      decoration: BoxDecoration(border: Border.all(color: const Color(0xff999999)), borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("${date.value.day}-${date.value.month}-${date.value.year}", style: AppTextStyles.hintTextStyle.copyWith(fontSize: 16.sp)),
          SvgPicture.asset("assets/icons/date_medi.svg", height: 3.h),
        ],
      ),
    ),
  ));

  Widget _buildDropdown(RxString selectedValue, List<String> items, String hint) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(hint, style: AppTextStyles.smallTextStyle),
      verticalSpace(0.4.h),
      Obx(() => DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: Text(hint, style: AppTextStyles.smallTextStyle.copyWith(color: Colors.grey)),
          value: selectedValue.value,
          items: items
              .map((item) => DropdownMenuItem(value: item, child: Text(item, style: AppTextStyles.smallTextStyle.copyWith(color: AppColors.textColor))))
              .toList(),
          onChanged: (value) => selectedValue.value = value!,
          buttonStyleData: ButtonStyleData(
            height: 6.h,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.sp),
              border: Border.all(color: const Color(0xff999999), width: 1),
            ),
          ),
          dropdownStyleData: DropdownStyleData(maxHeight: 25.h, decoration: BoxDecoration(borderRadius: BorderRadius.circular(14.sp), color: Colors.white), elevation: 4),
          menuItemStyleData: MenuItemStyleData(height: 5.5.h, padding: EdgeInsets.symmetric(horizontal: 3.w)),
        ),
      )),
    ],
  );

  Widget _buildDoseTimeRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 3.w,
          runSpacing: 1.5.h,
          children: List.generate(6, (i) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${i + 1}dose_time".tr, style: AppTextStyles.smallTextStyle),
              verticalSpace(0.5.h),
              Obx(() => GestureDetector(
                onTap: () async {
                  TimeOfDay initial = controller.doseTimes[i].value.isEmpty
                      ? TimeOfDay.now()
                      : TimeOfDay(
                    hour: int.parse(controller.doseTimes[i].value.split(':')[0]),
                    minute: int.parse(controller.doseTimes[i].value.split(':')[1].split(' ')[0]),
                  );
                  TimeOfDay? picked = await showTimePicker(context: Get.context!, initialTime: initial);
                  if (picked != null) {
                    controller.doseTimes[i].value =
                    "${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')} ${controller.formatTime(picked.hour)}";
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.3.h),
                  width: 28.w,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xff999999))),
                  child: Text(
                    controller.doseTimes[i].value.isEmpty ? "00:00 AM" : controller.doseTimes[i].value,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.hintTextStyle,
                  ),
                ),
              )),
            ],
          )),
        ),
      ],
    );
  }

  void _onSave() => ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text("medicine_saved".tr)));
}