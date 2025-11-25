import 'package:fakrny/controllers/auth_controller.dart';
import 'package:fakrny/utils/app_colors.dart';
import 'package:fakrny/utils/app_text_styles.dart';
import 'package:fakrny/views/reused_widgets/elevated_button.dart';
import 'package:fakrny/views/reused_widgets/text_filed.dart';
import 'package:fakrny/views/reused_widgets/vertical_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';

import 'verify_otp_screen.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});

  final AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/blur_bg.png"),fit: BoxFit.fitWidth)
        ),
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Stack(
          children: [
            Positioned(
                top: 22.h,
                left: 0,
                right: 0,
                child:Column(children: [
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
                  Text("Fakrny", style: AppTextStyles.boldTextStyle.copyWith(
                    color:  Colors.white.withOpacity(0.4),
                  )),
                  Text(
                    "Your Smart Partner for Timely\n Medication",
                    style: AppTextStyles.semiBoldTextStyle.copyWith(
                      color:  Colors.white.withOpacity(0.4),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],)
            ),

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

                      Text("Forgot Password", style: AppTextStyles.boldTextStyle.copyWith(
                        color: AppColors.black,

                      )),
                      verticalSpace(0.4.h),

                      Text("A verification code will be sent to your email to\n reset your password.", style: AppTextStyles.smallTextStyle,
                        textAlign: TextAlign.center,),
                      verticalSpace(3.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Email", style: AppTextStyles.smallTextStyle),
                        ],
                      ),
                      verticalSpace(.4.h),

                      /// Email Field
                      customTextField(
                        hintText: "My Email",
                        controller: controller.forgotEmailCtrl,
                        iconPath: "assets/icons/email.svg",
                      ),

                      verticalSpace(6.h),


                      CustomButton(height: 5.5.h, title: "Send Verification Code", onTap: () {
                        Get.to(()=>VerifyOtpScreen());
                      }),

                      verticalSpace(2.h),




                    ],
                  ),
                ),
              ),
            ),
            Positioned(bottom: 38.h,
                left: 0,
                right: 0,
                child:   SizedBox(
                  height: 12.h,
                  width: 12.h,
                  child:   Image.asset("assets/images/forgot_password.png"),
                ))
          ],
        ),
      )
    );
  }
}
