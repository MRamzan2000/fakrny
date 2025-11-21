import 'package:fakrny/controllers/auth_controller.dart';
import 'package:fakrny/utils/app_colors.dart';
import 'package:fakrny/utils/app_text_styles.dart';
import 'package:fakrny/views/reused_widgets/elevated_button.dart';
import 'package:fakrny/views/reused_widgets/text_filed.dart';
import 'package:fakrny/views/reused_widgets/vertical_space.dart';
import 'package:fakrny/views/screens/auth_screens/password_update.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';
class CreateNewPassword extends StatelessWidget {
  CreateNewPassword({super.key});

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
                  top: 20.h,
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

                        Text("Set a New Password", style: AppTextStyles.boldTextStyle.copyWith(
                          color: AppColors.black,

                        )),
                        verticalSpace(0.4.h),

                        Text("Please set a new password to secure your Work\n Mate account.", style: AppTextStyles.smallTextStyle,
                          textAlign: TextAlign.center,),
                        verticalSpace(3.h),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Password", style: AppTextStyles.smallTextStyle),
                          ],
                        ),
                        verticalSpace(.4.h),

                        /// Email Field
                        CustomTextField(
                          hintText: "Input Password",
                          controller: controller.newPasswordCtrl,
                          iconPath: "assets/icons/password.svg",
                          isPassword: true,
                          obscureText: controller.obscure.value,
                          suffixIcon: controller.obscure.value
                              ? SvgPicture.asset("assets/icons/eye_off.svg")
                              : SvgPicture.asset("assets/icons/eye_on.svg"),
                          onSuffixTap: controller.toggleObscure,
                        ),
                        verticalSpace(1.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Confirm Password", style: AppTextStyles.smallTextStyle),
                          ],
                        ),
                        verticalSpace(.4.h),

                        /// Email Field
                        CustomTextField(
                          hintText: "Re Enter Your Password",
                          controller: controller.confirmNewPasswordCtrl,
                          iconPath: "assets/icons/password.svg",
                          isPassword: true,
                          obscureText: controller.obscure.value,
                          suffixIcon: controller.obscure.value
                              ? SvgPicture.asset("assets/icons/eye_off.svg")
                              : SvgPicture.asset("assets/icons/eye_on.svg"),
                          onSuffixTap: controller.toggleObscure,
                        ),

                        verticalSpace(6.h),


                        CustomButton(height: 5.5.h, title: "Submit", onTap: () {
                          Get.to(()=>PasswordUpdate());
                        }),

                        verticalSpace(2.h),




                      ],
                    ),
                  ),
                ),
              ),
              Positioned(bottom: 48.h,
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
