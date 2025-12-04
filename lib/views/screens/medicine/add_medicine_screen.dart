import 'package:fakrny/utils/app_colors.dart';
import 'package:fakrny/utils/app_text_styles.dart';
import 'package:fakrny/views/reused_widgets/elevated_button.dart';
import 'package:fakrny/views/reused_widgets/horizontal_space.dart';
import 'package:fakrny/views/reused_widgets/reused_able_appbar.dart';
import 'package:fakrny/views/reused_widgets/vertical_space.dart';
import 'package:fakrny/views/screens/medicine/add_medicine_screen_details.dart';
import 'package:fakrny/views/screens/medicine/scan_medicine_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddMedicineScreen extends StatefulWidget {
  const AddMedicineScreen({super.key});

  @override
  State<AddMedicineScreen> createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  RxString isSelected = "Manually".obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: 100.h,
          width: 100.w,
          child: Column(
            children: [
              // AppBar title translate
              appBar(title: "add_medicine".tr),

              const Expanded(flex: 1, child: SizedBox()),

              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Manually Option
                        GestureDetector(
                          onTap: () => isSelected.value = "Manually",
                          child: _optionCard(
                            iconPath: "assets/icons/manual_medicine.svg",
                            title: "manually".tr,
                            borderColor: isSelected.value == "Manually"
                                ? AppColors.primaryColor
                                : const Color(0xff999999),
                          ),
                        ),
                        horizontalSpace(6.w),

                        // Scanning Option
                        GestureDetector(
                          onTap: () => isSelected.value = "Scanning",
                          child: _optionCard(
                            iconPath: "assets/icons/scan_medicine.svg",
                            title: "scanning".tr,
                            borderColor: isSelected.value == "Scanning"
                                ? AppColors.primaryColor
                                : const Color(0xff999999),
                          ),
                        ),
                      ],
                    )),

                    const Spacer(),

                    // Next Button
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: CustomButton(
                        height: 5.5.h,
                        title: "next".tr,
                        onTap: () {
                          if (isSelected.value == "Manually") {
                            Get.to(() =>  AddMedicineScreenDetails());
                          } else {
                            Get.to(() => const ScanMedicine());
                          }
                        },
                      ),
                    ),

                    verticalSpace(7.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable card widget – title ab .tr use karega
  Widget _optionCard({
    required String iconPath,
    required String title,
    required Color borderColor,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.4.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.px),
        border: Border.all(color: borderColor, width: 1.5),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 6.3.h,
            child: SvgPicture.asset(iconPath),
          ),
          verticalSpace(.3.h),
          Text(
            title,
            style: AppTextStyles.boldTextStyle.copyWith(
              color: AppColors.textColor,
              fontSize: 19.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}