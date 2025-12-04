import 'package:fakrny/utils/app_colors.dart';
import 'package:fakrny/utils/app_text_styles.dart';
import 'package:fakrny/views/reused_widgets/vertical_space.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OnBoardingPage3 extends StatelessWidget {
  const OnBoardingPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        verticalSpace(13.85.h),
        SizedBox(
          height: 38.h,
          width: double.infinity,
          child: Image.asset("assets/images/onboarding_three.png", fit: BoxFit.fill),
        ),
        verticalSpace(1.2.h),
        Text(
          "onboard3_title".tr,
          style: AppTextStyles.boldTextStyle.copyWith(
            fontSize: 23.sp,
            color: AppColors.primaryColor,
          ),
        ),
        verticalSpace(.4.h),
        Text(
          "onboard3_subtitle".tr,
          style: AppTextStyles.semiBoldTextStyle.copyWith(
            fontSize: 20.sp,
            color: AppColors.black,
          ),
        ),
        verticalSpace(1.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Text(
            "onboard3_desc".tr,
            style: AppTextStyles.smallTextStyle,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}