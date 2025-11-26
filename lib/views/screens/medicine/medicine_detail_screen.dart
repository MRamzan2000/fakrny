import 'package:fakrny/utils/app_colors.dart';
import 'package:fakrny/utils/app_text_styles.dart';
import 'package:fakrny/views/reused_widgets/horizontal_space.dart';
import 'package:fakrny/views/reused_widgets/reused_able_appbar.dart';
import 'package:fakrny/views/reused_widgets/vertical_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MedicineDetailScreen extends StatelessWidget {
  const MedicineDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FFFB),
      body: SafeArea(
        child: Column(
          children: [
            // AppBar
            appBar(
              title: "Risek",
              // actions: [
              //   Padding(
              //     padding: EdgeInsets.only(right: 4.w),
              //     child: Text(
              //       "Edit",
              //       style: AppTextStyles.regularTextStyle.copyWith(
              //         color: AppColors.primaryColor,
              //         fontSize: 17.sp,
              //       ),
              //     ),
              //   ),
              // ],
            ),

            verticalSpace(2.h),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Medicine Image
                    Center(
                      child: Image.asset(
                        "assets/images/risek.png",
                        height: 35.h,
                        fit: BoxFit.contain,
                      ),
                    ),

                    verticalSpace(1.5.h),

                    // Medicine Name
                    _buildInfoRow(
                      icon: "assets/icons/name_medi.svg",
                      label: "Medicine Name",
                      value: "Risek",
                    ),

                    verticalSpace(2.h),

                    // Dosage
                    _buildInfoRow(
                      icon: "assets/icons/dosage_medi.svg",
                      label: "Medicine Dosage(mg, ml, mcg, IU, etc.)",
                      value: "20",
                    ),

                    verticalSpace(2.h),

                    // Dose & Stock Row
                    Row(
                      children: [
                        Expanded(
                          child: _buildSmallInfo(
                            icon: "assets/icons/dose_medi.svg",
                            label: "Medicine Dose",
                            value: "1 Capsule",
                          ),
                        ),
                        horizontalSpace(4.w),
                        Expanded(
                          child: _buildSmallInfo(
                            icon: "assets/icons/stock_medi.svg",
                            label: "Medicine Stock",
                            value: "24",
                          ),
                        ),
                      ],
                    ),

                    verticalSpace(3.h),

                    // Dosage Frequency & Time Section
                    Text(
                      "Dosage Frequency & Time",
                      style: AppTextStyles.semiBoldTextStyle.copyWith(
                        fontSize: 17.sp,
                        color: AppColors.textColor,
                      ),
                    ),

                    verticalSpace(1.5.h),

                    // Start & End Date
                    Row(
                      children: [
                        Expanded(
                          child: _buildDateBox(
                            label: "Start Date",
                            date: "12-Jan-2025",
                          ),
                        ),
                        horizontalSpace(3.w),
                        Expanded(
                          child: _buildDateBox(
                            label: "End Date",
                            date: "15-Jan-2025",
                          ),
                        ),
                      ],
                    ),

                    verticalSpace(2.h),

                    // Frequency
                    Text(
                      "Dosage Frequency",
                      style: AppTextStyles.smallTextStyle,
                    ),
                    verticalSpace(0.8.h),
                    Text(
                      "3 times per day",
                      style: AppTextStyles.regularTextStyle.copyWith(fontSize: 16.sp),
                    ),

                    verticalSpace(1.5.h),

                    // Dose Times
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildTimeBox("1 Dose Time", "09:00 AM"),
                        _buildTimeBox("2 Dose Time", "02:00 PM"),
                        _buildTimeBox("3 Dose Time", "08:00 PM"),
                      ],
                    ),

                    verticalSpace(3.h),

                    // Medicine Instructions
                    Text(
                      "Medicine Instructions",
                      style: AppTextStyles.semiBoldTextStyle.copyWith(
                        fontSize: 17.sp,
                        color: AppColors.textColor,
                      ),
                    ),

                    verticalSpace(1.5.h),

                    // How it should be taken
                    _buildInstructionRow("How it should be taken", "Empty Stomach"),

                    verticalSpace(2.h),

                    // Special instructions
                    _buildInstructionRow("Special instructions", "Take with milk"),

                    verticalSpace(4.h),

                    // Voice & Sound Alert
                    Text(
                      "Voice & Sound Alert",
                      style: AppTextStyles.semiBoldTextStyle.copyWith(
                        fontSize: 17.sp,
                        color: AppColors.textColor,
                      ),
                    ),

                    verticalSpace(1.5.h),

                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14.sp),
                        border: Border.all(color: AppColors.borderGrey),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Voice Alert",
                            style: AppTextStyles.smallTextStyle,
                          ),
                          verticalSpace(1.h),
                          Text(
                            "It's time to take your white pill after your meal.",
                            style: AppTextStyles.regularTextStyle.copyWith(fontSize: 16.sp),
                          ),
                          verticalSpace(2.h),
                          Center(
                            child: Container(
                              width: 50.w,
                              padding: EdgeInsets.symmetric(vertical: 1.2.h),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xff1FB774), Color(0xff63E4AE)],
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child: Text(
                                  "Stop",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    verticalSpace(8.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable Widgets

  Widget _buildInfoRow({required String icon, required String label, required String value}) {
    return Row(
      children: [
        SvgPicture.asset(icon, height: 3.5.h),
        horizontalSpace(3.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTextStyles.smallTextStyle),
              verticalSpace(0.5.h),
              Text(value, style: AppTextStyles.regularTextStyle.copyWith(fontSize: 17.sp)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSmallInfo({required String icon, required String label, required String value}) {
    return Row(
      children: [
        SvgPicture.asset(icon, height: 3.h),
        horizontalSpace(2.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTextStyles.smallTextStyle.copyWith(fontSize: 15.sp)),
              verticalSpace(0.5.h),
              Text(value, style: AppTextStyles.regularTextStyle.copyWith(fontSize: 16.sp)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDateBox({required String label, required String date}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.smallTextStyle),
        verticalSpace(0.8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xff999999)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(date, style: AppTextStyles.hintTextStyle.copyWith(fontSize: 16.sp)),
              SvgPicture.asset("assets/icons/date_medi.svg", height: 3.h),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimeBox(String label, String time) {
    return Column(
      children: [
        Text(label, style: AppTextStyles.smallTextStyle),
        verticalSpace(0.8.h),
        Container(
          padding: EdgeInsets.symmetric(vertical: 1.2.h, horizontal: 5.w),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xff999999)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(time, style: AppTextStyles.regularTextStyle.copyWith(fontSize: 16.sp)),
        ),
      ],
    );
  }

  Widget _buildInstructionRow(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.smallTextStyle),
        verticalSpace(0.8.h),
        Text(value, style: AppTextStyles.regularTextStyle.copyWith(fontSize: 16.sp)),
      ],
    );
  }
}