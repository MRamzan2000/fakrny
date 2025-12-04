import 'package:fakrny/utils/app_colors.dart';
import 'package:fakrny/utils/app_text_styles.dart';
import 'package:fakrny/views/reused_widgets/horizontal_space.dart';
import 'package:fakrny/views/reused_widgets/vertical_space.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'medicine/medicine_detail_screen.dart';

class MyMedsScreen extends StatelessWidget {
  const MyMedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> medicines = [
      {
        "image": "assets/images/risek.png",
        "name": "Risek".tr,
        "dosage": "dosage_3_times_day".tr,
        "details": "details_started_july".tr
      },
      {
        "image": "assets/images/captopril.png",
        "name": "Captopril".tr,
        "dosage": "dosage_1_time_day".tr,
        "details": "details_started_july".tr
      },
      {
        "image": "assets/images/sudafed.png",
        "name": "I-DROP MGD".tr,
        "dosage": "dosage_2_times_day_drops".tr,
        "details": "details_started_july_drops".tr
      },
    ];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.white,
          automaticallyImplyLeading: false,
          title: Text(
            "my_medication".tr,
            style: AppTextStyles.semiBoldTextStyle.copyWith(
              fontSize: 20.sp,
              color: AppColors.textColor,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(3.h),

                // Active / Ended Tabs
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: .5.h),
                  height: 6.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(25.px),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 22,
                        spreadRadius: 1,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: TabBar(
                    labelStyle: AppTextStyles.smallTextStyle.copyWith(color: AppColors.textColor),
                    tabs: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Tab(text: 'active'.tr),
                          horizontalSpace(2.w),
                          Container(
                            padding: EdgeInsets.all(.5.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(70.px),
                              color: const Color(0xff0B2455),
                            ),
                            child: Text("2", style: AppTextStyles.smallTextStyle.copyWith(color: AppColors.white)),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Tab(text: 'ended'.tr),
                          horizontalSpace(2.w),
                          Container(
                            padding: EdgeInsets.all(.5.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(70.px),
                              color: const Color(0xff0B2455),
                            ),
                            child: Text("1", style: AppTextStyles.smallTextStyle.copyWith(color: AppColors.white)),
                          ),
                        ],
                      ),
                    ],
                    indicatorPadding: EdgeInsets.zero,
                    indicatorSize: TabBarIndicatorSize.tab,
                    padding: EdgeInsets.zero,
                    labelPadding: EdgeInsets.zero,
                    dividerColor: Colors.transparent,
                    indicator: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    labelColor: AppColors.white,
                    unselectedLabelColor: AppColors.grey,
                  ),
                ),

                verticalSpace(4.h),

                // Medicine List
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    itemCount: medicines.length,
                    separatorBuilder: (context, index) => SizedBox(height: 2.h),
                    itemBuilder: (context, index) {
                      final item = medicines[index];
                      return GestureDetector(
                        onTap: () => Get.to(() => MedicineDetailScreen(title: item["name"], image: item["image"])),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.3.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18.sp),
                            color: AppColors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
                            ],
                          ),
                          child: Row(
                            children: [
                              // IMAGE
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12.sp),
                                child: Container(
                                  height: 10.h,
                                  color: const Color(0xffF6F6F6),
                                  child: Image.asset(item["image"], fit: BoxFit.contain),
                                ),
                              ),
                              horizontalSpace(4.w),

                              // TEXT
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item["name"],
                                      style: AppTextStyles.semiBoldTextStyle.copyWith(
                                        fontSize: 18.sp,
                                        color: const Color(0xff353535),
                                      ),
                                    ),
                                    verticalSpace(0.5.h),
                                    Text(
                                      item["dosage"],
                                      style: AppTextStyles.smallTextStyle.copyWith(
                                        fontSize: 16.sp,
                                        color: const Color(0xff353535),
                                      ),
                                    ),
                                    verticalSpace(1.h),
                                    Text(
                                      item["details"],
                                      style: AppTextStyles.smallTextStyle.copyWith(
                                        fontSize: 14.sp,
                                        color: const Color(0xff353535),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}