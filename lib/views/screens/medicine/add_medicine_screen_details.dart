import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fakrny/controllers/medicine_controller.dart';
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
              appBar(title: "Add Medicine"),
              verticalSpace(2.h),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildMedicinePictureSection(),
                      verticalSpace(2.h),
                      _buildLabeledField(
                        "Medicine Name",
                        _buildTextField(
                          controller.name,
                          "Name",
                          "assets/icons/name_medi.svg",
                        ),
                      ),
                      verticalSpace(1.5.h),
                      _buildLabeledField(
                        "Medicine Dosage",
                        _buildTextField(
                          controller.dosage,
                          "Dosage",
                          "assets/icons/dosage_medi.svg",
                        ),
                      ),
                      verticalSpace(1.5.h),
                      Row(
                        children: [
                          Expanded(
                            child: _buildLabeledField(
                              "Medicine Dose",
                              _buildTextField(
                                controller.dose,
                                "Dose",
                                "assets/icons/dose_medi.svg",
                              ),
                            ),
                          ),
                          horizontalSpace(2.w),
                          Expanded(
                            child: _buildLabeledField(
                              "Medicine Stock",
                              _buildTextField(
                                controller.stock,
                                "Stock",
                                "assets/icons/stock_medi.svg",
                              ),
                            ),
                          ),
                        ],
                      ),
                      verticalSpace(1.5.h),
                      Text(
                        "Dosage Frequency & Time",
                        style: AppTextStyles.smallTextStyle,
                      ),
                      verticalSpace(1.h),
                      Row(
                        children: [
                          Expanded(
                            child: _buildDateField(
                              "Start Date",
                              controller.startDate,
                            ),
                          ),
                          horizontalSpace(2.w),
                          Expanded(
                            child: _buildDateField(
                              "End Date",
                              controller.endDate,
                            ),
                          ),
                        ],
                      ),
                      verticalSpace(1.h),
                      _buildDropdown(
                        controller.frequency,
                        controller.frequencyOptions,
                        "Dosage Frequency",
                      ),
                      verticalSpace(1.h),
                      _buildDoseTimeRow(),
                      verticalSpace(2.h),
                      _buildDropdown(
                        controller.howToTake,
                        controller.howToTakeOptions,
                        "How it should be taken",
                      ),
                      verticalSpace(1.h),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 3.w),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(14.sp),
                          border: Border.all(color: AppColors.borderGrey,),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child:
                                  TextField(
                                    maxLines:5 ,
                                    style: AppTextStyles.hintTextStyle,
                                    decoration: InputDecoration(
                                      isCollapsed: true,
                                      border: InputBorder.none,
                                      hintText: "Special instructions",
                                      hintStyle: TextStyle(fontSize: 16.sp, color: Colors.grey),
                                    ),
                                  ),
                            ),

                          ],
                        ),
                      ),
                      verticalSpace(1.5.h),
                      VoiceSoundAlertUI(),
                      verticalSpace(4.h),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _onSave,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: EdgeInsets.symmetric(vertical: 1.6.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: Text(
                            "Save",
                            style: AppTextStyles.semiBoldTextStyle.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      verticalSpace(2.h),
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

  //Reusable Widgets
  Widget _buildMedicinePictureSection() => GestureDetector(
    onTap: () => _showImagePickerPopup(),
    child: Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 26.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xff999999), width: 1.5),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 12.h,
            width: 12.h,
            child: SvgPicture.asset("assets/icons/image_pic.svg"),
          ),
          verticalSpace(1.5.h),
          Text(
            "Add Medicine Picture",
            style: AppTextStyles.hintTextStyle.copyWith(
              color: const Color(0xff999999),
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    ),
  );
  void _showImagePickerPopup() {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(22),
            topRight: Radius.circular(22),
          ),
        ),
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt, size: 28),
              title: const Text("Take Photo"),
              onTap: () {
                controller.pickFromCamera();
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo, size: 28),
              title: const Text("Choose from Gallery"),
              onTap: () {
                controller.pickFromGallery();
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.close, size: 28),
              title: const Text("Cancel"),
              onTap: () => Get.back(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabeledField(String label, Widget field) =>
      Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      label.isEmpty
          ? SizedBox.shrink()
          : Text(label, style: AppTextStyles.smallTextStyle),
      verticalSpace(0.4.h),
      field,
    ],
  );

  Widget _buildTextField(
    TextEditingController controller,
    String hint,
    String iconPath,
  ) =>
      customTextField(
    hintText: hint,
    controller: controller,
    iconPath: iconPath,
  );


  Widget _buildDateField(String label, Rx<DateTime> date) => Obx(
    () => GestureDetector(
      onTap: () async {
        DateTime? selected = await showDatePicker(
          context: Get.context!,
          initialDate: date.value.isBefore(DateTime.now())
              ? DateTime.now()
              : date.value,
          firstDate: DateTime.now(),
          lastDate: DateTime(2030),
          builder: (context, child) => Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: AppColors.primaryColor,
                onPrimary: Colors.white,
                onSurface: AppColors.textColor,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.primaryColor,
                ),
              ),
            ),
            child: child!,
          ),
        );
        if (selected != null) date.value = selected;
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.2.h),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xff999999)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${date.value.day}-${date.value.month}-${date.value.year}",
              style: AppTextStyles.hintTextStyle.copyWith(fontSize: 16.sp),
            ),
            SvgPicture.asset("assets/icons/date_medi.svg", height: 3.h),
          ],
        ),
      ),
    ),
  );

  Widget _buildDropdown(
    RxString selectedValue,
    List<String> items,
    String hint,
  ) =>
      Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(hint, style: AppTextStyles.smallTextStyle),
      verticalSpace(0.4.h),
      Obx(
        () => DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            hint: Text(
              hint,
              style: AppTextStyles.smallTextStyle.copyWith(color: Colors.grey),
            ),
            value: selectedValue.value,
            items: items
                .map(
                  (item) => DropdownMenuItem(
                    value: item,
                    child: Text(
                      item,
                      style: AppTextStyles.smallTextStyle.copyWith(
                        color: AppColors.textColor,
                      ),
                    ),
                  ),
                )
                .toList(),
            onChanged: (value) => selectedValue.value = value!,
            buttonStyleData: ButtonStyleData(
              height: 6.h,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.sp),
                border: Border.all(color: const Color(0xff999999), width: 1),
                color: Colors.transparent,
              ),
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 25.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.sp),
                color: Colors.white,
              ),
              elevation: 4,
              offset: const Offset(0, 0),
            ),
            menuItemStyleData: MenuItemStyleData(
              height: 5.5.h,
              padding: EdgeInsets.symmetric(horizontal: 3.w),
            ),
          ),
        ),
      ),
    ],
  );

  Widget _buildDoseTimeRow() {
    int numDoses =6;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 3.w,
          runSpacing: 1.5.h,
          children: List.generate(numDoses, (i) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${i + 1} Dose Time",
                  style: AppTextStyles.smallTextStyle,
                ),
                verticalSpace(0.5.h),
                Obx(
                      () => GestureDetector(
                    onTap: () async {
                      TimeOfDay initial = controller.doseTimes[i].value.isEmpty
                          ? TimeOfDay.now()
                          : TimeOfDay(
                        hour: int.parse(
                          controller.doseTimes[i].value.split(':')[0],
                        ),
                        minute: int.parse(
                          controller.doseTimes[i].value
                              .split(':')[1]
                              .split(' ')[0],
                        ),
                      );

                      TimeOfDay? picked = await showTimePicker(
                        context: Get.context!,
                        initialTime: initial,
                      );

                      if (picked != null) {
                        controller.doseTimes[i].value =
                        "${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')} ${controller.formatTime(picked.hour)}";
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                        vertical: 1.3.h,
                      ),
                      width: 28.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xff999999)),
                      ),
                      child: Text(
                        controller.doseTimes[i].value.isEmpty
                            ? "00:00 AM"
                            : controller.doseTimes[i].value,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.hintTextStyle,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ],
    );
  }



  void _onSave() => ScaffoldMessenger.of(
    Get.context!,
  ).showSnackBar(const SnackBar(content: Text('Medicine saved!')));
}
