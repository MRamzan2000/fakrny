import 'package:fakrny/utils/app_colors.dart';
import 'package:fakrny/utils/app_text_styles.dart';
import 'package:fakrny/views/reused_widgets/vertical_space.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OnBoardingPage1 extends StatelessWidget {
  const OnBoardingPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        verticalSpace(14.h),

        SizedBox(
          height: 38.h,
          width: double.infinity,
          child: Image.asset(
            "assets/images/onboarding_one.png",
            fit: BoxFit.fill,
          ),
        ),

        Text(
          "Smart",
          style: AppTextStyles.boldTextStyle.copyWith(
            fontSize: 20.sp,
            color: AppColors.primaryColor,
          ),
        ),

        verticalSpace(.4.h),

        Text(
          "Never Miss a Dose Again",
          style: AppTextStyles.semiBoldTextStyle.copyWith(
            fontSize: 21.sp,
            color: AppColors.black,
          ),
        ),

        verticalSpace(1.h),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Text(
            "Get smart alerts before or after meals —\n always on time, every time.",
            style: AppTextStyles.smallTextStyle,
            textAlign: TextAlign.center,
          ),
        ),

      ],
    );
  }
}
