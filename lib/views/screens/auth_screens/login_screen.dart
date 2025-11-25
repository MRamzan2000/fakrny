import 'package:fakrny/controllers/auth_controller.dart';
import 'package:fakrny/utils/app_colors.dart';
import 'package:fakrny/utils/app_text_styles.dart';
import 'package:fakrny/views/reused_widgets/elevated_button.dart';
import 'package:fakrny/views/reused_widgets/horizontal_space.dart';
import 'package:fakrny/views/reused_widgets/text_filed.dart';
import 'package:fakrny/views/reused_widgets/vertical_space.dart';
import 'package:fakrny/views/screens/auth_screens/forget_password_screen.dart';
import 'package:fakrny/views/screens/auth_screens/signup_screen.dart';
import 'package:fakrny/views/screens/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

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
              child: Transform.scale(
                scale: 0.13.h,
                child: SvgPicture.asset(
                  "assets/icons/ts_logo.svg",
                  colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.4),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(6.w, 2.h, 6.w, 2.h),
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
                      Text("Sign In", style: AppTextStyles.greenBoldTextStyle),
                      verticalSpace(0.4.h),

                      Text(
                        "Sign in with Email",
                        style: AppTextStyles.smallTextStyle,
                      ),
                      verticalSpace(2.h),

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
                        controller: controller.emailCtrl,
                        iconPath: "assets/icons/email.svg",
                      ),

                      verticalSpace(1.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Password", style: AppTextStyles.smallTextStyle),
                        ],
                      ),
                      verticalSpace(.4.h),

                      /// PASSWORD FIELD (Reactive)
                      Obx(
                        () => customTextField(
                          hintText: "My Password",
                          controller: controller.passCtrl,
                          iconPath: "assets/icons/password.svg",
                          isPassword: true,
                          obscureText: controller.obscure.value,
                          suffixIcon: controller.obscure.value
                              ? SvgPicture.asset("assets/icons/eye_off.svg")
                              : SvgPicture.asset("assets/icons/eye_on.svg"),
                          onSuffixTap: controller.toggleObscure,
                        ),
                      ),

                      verticalSpace(2.h),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(
                              () => Row(
                                children: [
                                  GestureDetector(
                                    onTap: controller.toggleRemember,
                                    child: Container(
                                      height: 18.sp,
                                      width: 18.sp,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                          color: AppColors.primaryColor,
                                          width: 2,
                                        ),
                                        color: controller.remember.value
                                            ? AppColors.secondaryColor
                                            : AppColors.white,
                                      ),
                                      child: controller.remember.value
                                          ? Icon(
                                              Icons.check,
                                              size: 16.sp,
                                              color: AppColors.primaryColor,
                                            )
                                          : null,
                                    ),
                                  ),
                                  horizontalSpace(1.8.w),
                                  Text(
                                    "Remember Me",
                                    style: AppTextStyles.smallTextStyle,
                                  ),
                                ],
                              ),
                            ),

                            GestureDetector(
                              onTap: () {
                                Get.to(() => ForgetPasswordScreen());
                              },
                              child: Text(
                                "Forgot Password",
                                style: AppTextStyles.smallTextStyle.copyWith(),
                              ),
                            ),
                          ],
                        ),
                      ),

                      verticalSpace(3.h),

                      /// LOGIN BUTTON
                      CustomButton(height: 5.5.h, title: "Login", onTap: () {
                        Get.to(()=>BottomBar());
                      }),

                      verticalSpace(2.h),

                      /// OR Divider
                      Row(
                        children: [
                          Expanded(child: Divider(color: Colors.grey.shade300)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            child: Text(
                              "OR",
                              style: AppTextStyles.hintTextStyle,
                            ),
                          ),
                          Expanded(child: Divider(color: Colors.grey.shade300)),
                        ],
                      ),

                      verticalSpace(2.h),

                      /// GOOGLE SIGN IN
                      CustomButton(
                        height: 5.4.h,
                        iconPath: "assets/icons/google.svg",
                        horizontal: 2.w,
                        title: "Sign In With Google",
                        onTap: () {},
                        isGradient: false,
                        color: const Color(0xffF4F8FB),
                        border: Border.all(
                          color: const Color(0xff1FB774),
                          width: 2,
                        ),
                        textColor: AppColors.primaryColor,
                      ),

                      verticalSpace(2.h),

                      GestureDetector(
                        onTap: (){
                          Get.to(()=>SignupScreen());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "I don’t have an account? ",
                              style: AppTextStyles.smallTextStyle.copyWith(
                                color: AppColors.borderGrey,
                              ),
                            ),
                            Text(
                              "Sign Up",
                              style: AppTextStyles.greenBoldTextStyle.copyWith(
                                fontSize: 16.5.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
