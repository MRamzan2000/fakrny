import 'package:fakrny/controllers/auth_controller.dart';
import 'package:fakrny/utils/app_colors.dart';
import 'package:fakrny/utils/app_loadings.dart';
import 'package:fakrny/utils/app_message.dart';
import 'package:fakrny/utils/app_text_styles.dart';
import 'package:fakrny/views/reused_widgets/elevated_button.dart';
import 'package:fakrny/views/reused_widgets/horizontal_space.dart';
import 'package:fakrny/views/reused_widgets/text_filed.dart';
import 'package:fakrny/views/reused_widgets/vertical_space.dart';
import 'package:fakrny/views/screens/auth_screens/forget_password_screen.dart';
import 'package:fakrny/views/screens/auth_screens/signup_screen.dart';
import 'package:fakrny/views/screens/bottom_navigation_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController controller = Get.put(AuthController());
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  RxBool remember = false.obs;
  void toggleRemember() => remember.value = !remember.value;

  RxBool obscure = true.obs;

  void toggleObscure() => obscure.value = !obscure.value;

  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

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
            // Top Logo
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

            // Main White Card
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
                      Text("sign_in".tr, style: AppTextStyles.greenBoldTextStyle),
                      verticalSpace(0.4.h),
                      Text("sign_in_with_email".tr, style: AppTextStyles.smallTextStyle),
                      verticalSpace(2.h),
                      // Email
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [Text("email".tr, style: AppTextStyles.smallTextStyle)],
                      ),
                      verticalSpace(.4.h),
                      customTextField(
                        hintText: "hint_email".tr,
                        controller: emailCtrl,
                        iconPath: "assets/icons/email.svg",
                      ),
                      verticalSpace(1.h),
                      // Password
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [Text("password".tr, style: AppTextStyles.smallTextStyle)],
                      ),
                      verticalSpace(.4.h),
                      Obx(() => customTextField(
                        hintText: "hint_password".tr,
                        controller: passwordCtrl,
                        iconPath: "assets/icons/password.svg",
                        isPassword: true,
                        obscureText: obscure.value,
                        suffixIcon: obscure.value
                            ? SvgPicture.asset("assets/icons/eye_off.svg")
                            : SvgPicture.asset("assets/icons/eye_on.svg"),
                        onSuffixTap: toggleObscure,
                      )),
                      verticalSpace(2.h),

                      // Remember + Forgot Password
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(() => Row(
                              children: [
                                GestureDetector(
                                  onTap: toggleRemember,
                                  child: Container(
                                    height: 18.sp,
                                    width: 18.sp,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                        color: AppColors.primaryColor,
                                        width: 2,
                                      ),
                                      color: remember.value
                                          ? AppColors.secondaryColor
                                          : AppColors.white,
                                    ),
                                    child: remember.value
                                        ? Icon(Icons.check,
                                        size: 16.sp, color: AppColors.primaryColor)
                                        : null,
                                  ),
                                ),
                                horizontalSpace(1.8.w),
                                Text("remember_me".tr, style: AppTextStyles.smallTextStyle),
                              ],
                            )),
                            GestureDetector(
                              onTap: () => Get.to(() => ForgetPasswordScreen()),
                              child: Text("forgot_password".tr, style: AppTextStyles.smallTextStyle),
                            ),
                          ],
                        ),
                      ),
                      verticalSpace(3.h),

                      // Login Button
                      CustomButton(
                        height: 5.5.h,
                        title: "login".tr,
                        onTap: (){
                          controller.loginWithEmail(email: emailCtrl.text, password: passwordCtrl.text,
                              rememberMe: remember.value);
                        },
                      ),
                      verticalSpace(2.h),

                      // OR Divider
                      Row(
                        children: [
                          Expanded(child: Divider(color: Colors.grey.shade300)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            child: Text("or".tr, style: AppTextStyles.hintTextStyle),
                          ),
                          Expanded(child: Divider(color: Colors.grey.shade300)),
                        ],
                      ),
                      verticalSpace(2.h),
                      CustomButton(
                        height: 5.4.h,
                        iconPath: "assets/icons/google.svg",
                        horizontal: 2.w,
                        title: "sign_in_with_google".tr,
                        onTap: () async {
                        controller.signInWithGoogle();
                        },
                        isGradient: false,
                        color: const Color(0xffF4F8FB),
                        border: Border.all(color: AppColors.primaryColor, width: 2),
                        textColor: AppColors.primaryColor,
                      ),

                      verticalSpace(2.h),

                      // Sign Up
                      GestureDetector(
                        onTap: () => Get.to(() => SignupScreen()),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "no_account".tr,
                              style: AppTextStyles.smallTextStyle.copyWith(color: AppColors.borderGrey),
                            ),
                            Text(
                              "sign_up".tr,
                              style: AppTextStyles.greenBoldTextStyle.copyWith(fontSize: 16.5.sp),
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
