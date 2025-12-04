import 'package:fakrny/utils/app_colors.dart';
import 'package:fakrny/utils/app_text_styles.dart';
import 'package:fakrny/utils/curved_reuseable.dart';
import 'package:fakrny/views/reused_widgets/elevated_button.dart';
import 'package:fakrny/views/reused_widgets/vertical_space.dart';
import 'package:fakrny/views/screens/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'auth_screens/login_screen.dart';
import 'auth_screens/signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  void _continueWithoutAccount() {
    Get.offAll(() => BottomBar());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: Stack(
        children: [
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
                    "app_name".tr,
                    style: AppTextStyles.boldTextStyle.copyWith(fontSize: 26.sp),
                  ),
                  verticalSpace(1.h),
                  Text(
                    "app_tagline".tr,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.semiBoldTextStyle.copyWith(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  verticalSpace(12.h),
                ],
              ),
            ),
          ),

          /// WHITE CARD AT BOTTOM
          Positioned(
            bottom: 0,
            left: 8.w,
            right: 8.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(30.px),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 25,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Sign Up Button
                  CustomButton(
                    title: "create_new_account".tr,
                    onTap: () => Get.to(() => SignupScreen()),
                    height: 5.8.h,
                    borderRadius: BorderRadius.circular(40.px),
                    border: Border.all(color: Colors.transparent),
                  ),

                  verticalSpace(2.h),

                  // Continue Without Account
                  CustomButton(
                    title: "continue_without_account".tr,
                    onTap: _continueWithoutAccount,
                    height: 5.8.h,
                    isGradient: false,
                    color: AppColors.white,
                    border: Border.all(color: AppColors.primaryColor, width: 1.5),
                    textColor: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(40.px),
                  ),

                  verticalSpace(2.5.h),

                  // Already have account? Sign In
                  GestureDetector(
                    onTap: () => Get.to(() => LoginScreen()),
                    child: Text(
                      "already_have_account_signin".tr,
                      style: AppTextStyles.buttonTextStyle.copyWith(
                        fontSize: 18.sp,
                        color: AppColors.borderGrey,
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