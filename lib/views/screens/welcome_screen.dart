import 'package:fakrny/utils/app_colors.dart';
import 'package:fakrny/utils/app_text_styles.dart';
import 'package:fakrny/utils/curved_reuseable.dart';
import 'package:fakrny/views/reused_widgets/elevated_button.dart';
import 'package:fakrny/views/reused_widgets/vertical_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'auth_screens/login_screen.dart';
import 'auth_screens/signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: Stack(
        children: [
          /// TOP GREEN SECTION
          ClipPath(
            clipper: SmoothBottomCurveClipper(),
            child: Container(
              height: 75.h,
              width: 100.w,
              color: AppColors.primaryColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.scale(
                    scale: .15.h,
                    child: SvgPicture.asset("assets/icons/app_logo.svg"),
                  ),
                  verticalSpace(1.7.h),
                  Text(
                    "Fakrny",
                    style: AppTextStyles.boldTextStyle.copyWith(
                      fontSize: 20.sp,
                    ),
                  ),
                  verticalSpace(1.h),
                  Text(
                    "Your Smart Partner for Timely\n Medication",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.semiBoldTextStyle.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  verticalSpace(12.h),
                ],
              ),
            ),
          ),

          /// WHITE CARD
          Positioned(
            bottom: 3.h,
            left: 10.w,
            right: 10.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.5.h),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(30.px),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 22,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  CustomButton(
                    title: "Create new account",
                    onTap: () {
                      Get.to(()=>SignupScreen());
                    },
                    height: 5.2.h,
                    borderRadius: BorderRadius.circular(40.px),
                  ),
                  verticalSpace(2.h),
                  GestureDetector(
                    onTap: (){
                      Get.to(()=>LoginScreen());
                    },
                    child: Text(
                      "Already have account?",
                      style: AppTextStyles.semiBoldTextStyle.copyWith(
                        color: AppColors.textColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
