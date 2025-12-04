import 'package:fakrny/utils/app_colors.dart';
import 'package:fakrny/utils/app_text_styles.dart';
import 'package:fakrny/utils/popups.dart';
import 'package:fakrny/views/reused_widgets/elevated_button.dart';
import 'package:fakrny/views/reused_widgets/horizontal_space.dart';
import 'package:fakrny/views/reused_widgets/reused_able_appbar.dart';
import 'package:fakrny/views/reused_widgets/vertical_space.dart';
import 'package:fakrny/views/screens/medicine/add_medicine_screen_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MedicineDetailScreen extends StatelessWidget {
  final String title;
  final String image;
  const MedicineDetailScreen({super.key, required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: AppColors.appBarColor,
              child: Row(
                children: [
                  Expanded(child: appBar(title: title)), // title already dynamic
                  Padding(
                    padding: EdgeInsets.only(right: 4.w),
                    child: InkWell(
                      onTap: () => Get.to(() => AddMedicineScreenDetails()),
                      child: Text(
                        "Edit".tr,
                        style: AppTextStyles.regularTextStyle.copyWith(
                          color: AppColors.primaryColor,
                          fontSize: 17.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Medicine Image
                    Center(
                      child: Image.asset(image, height: 35.h, fit: BoxFit.contain),
                    ),

                    // Medicine Name
                    _buildInfoRow(
                      icon: "assets/icons/name_medi.svg",
                      label: "medicine_name".tr,
                      value: "Risek".tr,
                    ),
                    verticalSpace(1.h),
                    const Divider(),
                    verticalSpace(.5.h),

                    // Dosage
                    _buildInfoRow(
                      icon: "assets/icons/dosage_medi.svg",
                      label: "medicine_dosage_label".tr,
                      value: "20".tr,
                    ),
                    verticalSpace(1.h),
                    const Divider(),
                    verticalSpace(.5.h),

                    // Dose & Stock Row
                    Row(
                      children: [
                        Expanded(
                          child: _buildSmallInfo(
                            icon: "assets/icons/dose_medi.svg",
                            label: "medicine_dose".tr,
                            value: "1_capsule".tr,
                          ),
                        ),
                        horizontalSpace(4.w),
                        Expanded(
                          child: _buildSmallInfo(
                            icon: "assets/icons/stock_medi.svg",
                            label: "medicine_stock".tr,
                            value: "24".tr,
                          ),
                        ),
                      ],
                    ),
                    verticalSpace(1.h),
                    const Divider(),
                    verticalSpace(.5.h),

                    // Dosage Frequency & Time Section
                    Text("dosage_frequency_time".tr, style: AppTextStyles.semiBoldTextStyle.copyWith(fontSize: 17.sp, color: AppColors.textColor)),
                    verticalSpace(1.h),

                    // Start & End Date
                    Row(
                      children: [
                        Expanded(child: _buildDateBox(label: "start_date".tr, date: "12-Jan-2025".tr)),
                        horizontalSpace(3.w),
                        Expanded(child: _buildDateBox(label: "end_date".tr, date: "15-Jan-2025".tr)),
                      ],
                    ),

                    verticalSpace(1.h),
                    const Divider(),
                    verticalSpace(.5.h),

                    // Frequency
                    Text("dosage_frequency".tr, style: AppTextStyles.semiBoldTextStyle.copyWith(fontSize: 17.sp, fontWeight: FontWeight.w400, color: AppColors.textColor)),
                    verticalSpace(0.8.h),
                    Text("3_times_per_day".tr, style: AppTextStyles.regularTextStyle.copyWith(fontSize: 16.sp)),

                    verticalSpace(1.h),

                    // Dose Times
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildTimeBox("1_dose_time".tr, "09:00 AM".tr),
                        _buildTimeBox("2_dose_time".tr, "02:00 PM".tr),
                        _buildTimeBox("3_dose_time".tr, "08:00 PM".tr),
                      ],
                    ),

                    verticalSpace(1.h),
                    const Divider(),
                    verticalSpace(.5.h),

                    // Medicine Instructions
                    Text("medicine_instructions".tr, style: AppTextStyles.semiBoldTextStyle.copyWith(fontSize: 17.sp, color: AppColors.textColor)),
                    verticalSpace(1.h),

                    _buildInstructionRow("how_to_take".tr, "empty_stomach".tr),
                    verticalSpace(1.h),
                    const Divider(),
                    verticalSpace(.5.h),

                    _buildInstructionRow("special_instructions".tr, "take_with_milk".tr),
                    verticalSpace(1.h),
                    const Divider(),
                    verticalSpace(.5.h),

                    // Voice & Sound Alert
                    Text("voice_sound_alert".tr, style: AppTextStyles.semiBoldTextStyle.copyWith(fontSize: 17.sp, color: AppColors.textColor)),
                    verticalSpace(1.h),
                    Text("voice_alert".tr, style: AppTextStyles.smallTextStyle),
                    verticalSpace(.3.h),
                    Text("voice_alert_message".tr, style: AppTextStyles.regularTextStyle.copyWith(fontSize: 16.sp)),
                    verticalSpace(1.h),
                    const Divider(),
                    verticalSpace(.5.h),

                    // Stop Button
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: CustomButton(
                        height: 5.5.h,
                        title: "stop_medicine".tr,
                        onTap: () => showStopMedicineDialog(context),
                      ),
                    ),

                    verticalSpace(7.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable Widgets (sab .tr ready)
  Widget _buildInfoRow({required String icon, required String label, required String value}) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: AppTextStyles.smallTextStyle.copyWith(fontSize: 16.5.sp, fontWeight: FontWeight.w400)),
      verticalSpace(.6.h),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(icon, height: 3.3.h),
          horizontalSpace(2.w),
          Text(value, style: AppTextStyles.regularTextStyle.copyWith(fontSize: 17.sp)),
        ],
      ),
    ],
  );

  Widget _buildSmallInfo({required String icon, required String label, required String value}) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: AppTextStyles.smallTextStyle.copyWith(fontSize: 16.5.sp, fontWeight: FontWeight.w400)),
      verticalSpace(.6.h),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(icon, height: 3.h),
          horizontalSpace(2.w),
          Text(value, style: AppTextStyles.regularTextStyle.copyWith(fontSize: 15.5.sp)),
        ],
      ),
    ],
  );

  Widget _buildDateBox({required String label, required String date}) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: AppTextStyles.smallTextStyle.copyWith(fontSize: 16.5.sp, fontWeight: FontWeight.w400)),
      verticalSpace(0.8.h),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(date, style: AppTextStyles.regularTextStyle.copyWith(fontSize: 15.5.sp)),
          horizontalSpace(3.w),
          SvgPicture.asset("assets/icons/date_medi.svg", height: 3.h),
        ],
      ),
    ],
  );

  Widget _buildTimeBox(String label, String time) => Column(
    children: [
      Text(label, style: AppTextStyles.smallTextStyle),
      verticalSpace(0.8.h),
      Text(time, style: AppTextStyles.regularTextStyle.copyWith(fontSize: 16.sp)),
    ],
  );

  Widget _buildInstructionRow(String title, String value) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: AppTextStyles.smallTextStyle),
      verticalSpace(0.8.h),
      Text(value, style: AppTextStyles.regularTextStyle.copyWith(fontSize: 16.sp)),
    ],
  );
}