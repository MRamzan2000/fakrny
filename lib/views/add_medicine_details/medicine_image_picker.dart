// widgets/medicine_image_picker.dart
import 'dart:io';
import 'package:fakrny/controllers/medicine_controller.dart';
import 'package:fakrny/utils/app_colors.dart';
import 'package:fakrny/utils/app_text_styles.dart';
import 'package:fakrny/views/reused_widgets/horizontal_space.dart';
import 'package:fakrny/views/reused_widgets/vertical_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MedicineImagePicker extends StatelessWidget {
  final MedicineController controller;
  const MedicineImagePicker({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showImagePicker(context),
      child: Obx(() => Container(
        width: double.infinity,
        padding: controller.selectedImagePath.value != null
            ? EdgeInsets.zero
            : EdgeInsets.symmetric(vertical: 4.h, horizontal: 26.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xffE0E0E0), width: 1.5),
        ),
        child: controller.selectedImagePath.value != null
            ? ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.file(File(controller.selectedImagePath.value!), fit: BoxFit.cover),
        )
            : Column(
          children: [
            SizedBox(height: 12.h, width: 12.h, child: SvgPicture.asset("assets/icons/image_pic.svg")),
            verticalSpace(1.5.h),
            Text("add_medicine_picture".tr, style: AppTextStyles.hintTextStyle.copyWith(color: const Color(0xff999999), fontSize: 16.sp)),
          ],
        ),
      )),
    );
  }

  void _showImagePicker(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xff1FB774), Color(0xff63E4AE)], begin: Alignment.centerLeft, end: Alignment.centerRight),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(22), topRight: Radius.circular(22)),
        ),
        child: Wrap(
          children: [
            ListTile(leading: Icon(Icons.camera_alt, color: AppColors.white), title: Text("take_photo".tr, style: TextStyle(color: AppColors.white)), onTap: () { controller.pickFromCamera(); Get.back(); }),
            ListTile(leading: Icon(Icons.photo, color: AppColors.white), title: Text("choose_from_gallery".tr, style: TextStyle(color: AppColors.white)), onTap: () { controller.pickFromGallery(); Get.back(); }),
            ListTile(leading: Icon(Icons.close, color: AppColors.white), title: Text("cancel".tr, style: TextStyle(color: AppColors.white)), onTap: () => Get.back()),
          ],
        ),
      ),
    );
  }
}