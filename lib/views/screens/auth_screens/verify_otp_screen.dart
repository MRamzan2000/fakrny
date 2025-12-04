import 'package:fakrny/controllers/auth_controller.dart';
import 'package:fakrny/utils/app_colors.dart';
import 'package:fakrny/utils/app_text_styles.dart';
import 'package:fakrny/views/reused_widgets/elevated_button.dart';
import 'package:fakrny/views/reused_widgets/vertical_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';
class VerifyOtpScreen extends StatelessWidget {
  VerifyOtpScreen({super.key});

  final AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/blur_bg.png"),
            fit: BoxFit.fitWidth,
          ),
        ),
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Stack(
          children: [
            Positioned(
              top: 22.h,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Transform.scale(
                    scale: 0.13.h,
                    child: SvgPicture.asset(
                      "assets/icons/ts_logo.svg",
                      colorFilter: ColorFilter.mode(
                        Colors.white.withOpacity(0.4),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  verticalSpace(1.5.h),
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

            // Main white card
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
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
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      verticalSpace(1.h),

                      // Title
                      Text(
                        "change_password".tr,
                        style: AppTextStyles.boldTextStyle.copyWith(
                          color: AppColors.black,
                          fontSize: 22.sp,
                        ),
                      ),
                      verticalSpace(0.4.h),

                      Text(
                        "otp_sent_desc".tr,
                        style: AppTextStyles.smallTextStyle.copyWith(fontSize: 16.sp),
                        textAlign: TextAlign.center,
                      ),
                      verticalSpace(3.h),

                      // Submit Button
                      CustomButton(
                        height: 5.5.h,
                        title: "submit".tr,
                        onTap: () {
                          Get.back();
                          Get.back();
                        },
                      ),

                      verticalSpace(2.h),
                    ],
                  ),
                ),
              ),
            ),

            // Bottom illustration
            Positioned(
              bottom: 28.h,
              left: 0,
              right: 0,
              child: SizedBox(
                height: 12.h,
                width: 12.h,
                child: Image.asset("assets/images/forgot_password.png"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}