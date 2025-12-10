import 'dart:async';
import 'package:fakrny/controllers/auth_controller.dart';
import 'package:fakrny/utils/app_colors.dart';
import 'package:fakrny/utils/app_text_styles.dart';
import 'package:fakrny/views/reused_widgets/elevated_button.dart';
import 'package:fakrny/views/reused_widgets/vertical_space.dart';
import 'package:fakrny/views/screens/auth_screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';

class VerifyEmailScreen extends StatefulWidget {
  final String name;
  final String uid;
  final String email;
  final dynamic gender;
  final Rx<DateTime?> dob;

  const VerifyEmailScreen({
    super.key,
    required this.name,
    required this.email,
    required this.gender,
    required this.dob,
    required this.uid,
  });

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final AuthController controller = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();

    /// Start email listener (safe)
    controller.startEmailVerificationListener(
      name: widget.name,
      email: widget.email,
      gender: widget.gender ?? "Unknown",
      dob: widget.dob,
    );

    /// Listen inside screen → navigation safe
    ever(controller.isEmailVerified, (verified) {
      if (verified == true) {
        Future.microtask(() {
          controller.saveUserToFirestore(
            name: widget.name,
            email: widget.email,
            gender: widget.gender ?? "Unknown",
            dob: widget.dob.value.toString(), uid: widget.uid,
          );

          Get.offAll(() => LoginScreen());
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Stack(
        children: [
          // Background
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/blur_bg.png"),
                fit: BoxFit.fitWidth,
              ),
            ),
            width: double.infinity,
            height: double.infinity,
          ),

          // Logo
          Positioned(
            top: 22.h,
            left: 0,
            right: 0,
            child: Column(
              children: [
                SvgPicture.asset(
                  "assets/icons/ts_logo.svg",
                  colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.4),
                    BlendMode.srcIn,
                  ),
                  height: 12.h,
                ),
                verticalSpace(1.h),
                Text(
                  "app_name".tr,
                  style: AppTextStyles.boldTextStyle.copyWith(
                    color: Colors.white.withOpacity(0.4),
                  ),
                ),
                Text(
                  "splash_subtitle".tr,
                  style: AppTextStyles.semiBoldTextStyle.copyWith(
                    color: Colors.white.withOpacity(0.4),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          // Bottom Card
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.fromLTRB(6.w, 8.h, 6.w, 3.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.sp),
                  topRight: Radius.circular(25.sp),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.10),
                    blurRadius: 25,
                    offset: const Offset(0, -6),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Icon
                  SizedBox(
                    height: 5.h,
                    child: Transform.scale(
                      scale: 2.5,
                      child: Image.asset("assets/images/forgot_password.png"),
                    ),
                  ),
                  verticalSpace(4.h),

                  Text(
                    "verify_email_title".tr,
                    style: AppTextStyles.boldTextStyle.copyWith(
                      color: AppColors.black,
                      fontSize: 22.sp,
                    ),
                  ),
                  verticalSpace(1.h),

                  Text(
                    "verify_email_desc".tr,
                    style: AppTextStyles.smallTextStyle.copyWith(fontSize: 16.sp),
                    textAlign: TextAlign.center,
                  ),
                  verticalSpace(4.h),

                  // SEND AGAIN
                  CustomButton(
                    height: 5.5.h,
                    title: "Resend_email".tr,
                    onTap: () async {
                      controller.resendVerificationEmail();
                    },
                  ),

                  verticalSpace(2.h),

                  GestureDetector(
                    onTap: () => Get.offAll(() => LoginScreen()),
                    child: Text(
                      "Back_to_login".tr,
                      style: AppTextStyles.greenBoldTextStyle.copyWith(fontSize: 16.sp),
                    ),
                  ),
                  verticalSpace(2.h),

                  // LOADING Indicator
                  Obx(() {
                    return !controller.isEmailVerified.value
                        ? Column(
                      children: [
                        LinearProgressIndicator(
                          color: AppColors.primaryColor,
                          backgroundColor: AppColors.primaryColor.withOpacity(0.3),
                        ),
                        verticalSpace(1.h),
                        Text(
                          "Waiting for email verification...",
                          style: AppTextStyles.smallTextStyle.copyWith(
                            fontSize: 14.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    )
                        : const SizedBox.shrink();
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
