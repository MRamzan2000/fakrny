import 'package:fakrny/controllers/auth_controller.dart';
import 'package:fakrny/utils/app_colors.dart';
import 'package:fakrny/utils/app_text_styles.dart';
import 'package:fakrny/views/reused_widgets/elevated_button.dart';
import 'package:fakrny/views/reused_widgets/horizontal_space.dart';
import 'package:fakrny/views/reused_widgets/text_filed.dart';
import 'package:fakrny/views/reused_widgets/vertical_space.dart';
import 'package:fakrny/views/screens/auth_screens/forget_password_screen.dart';
import 'package:fakrny/views/screens/auth_screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';
class SignupScreen extends StatelessWidget {
   SignupScreen({super.key});
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
        child:  Stack(
          children: [
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
                      Text("Sign Up", style: AppTextStyles.greenBoldTextStyle),
                      verticalSpace(0.4.h),

                      Text(
                        "Sign up with Email",
                        style: AppTextStyles.smallTextStyle,
                      ),
                      verticalSpace(2.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Name", style: AppTextStyles.smallTextStyle),
                        ],
                      ),
                      verticalSpace(.4.h),

                      /// Email Field
                      CustomTextField(
                        hintText: "My Name",
                        controller: controller.emailCtrl,
                        iconPath: "assets/icons/name.svg",
                      ),

                      verticalSpace(1.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Email", style: AppTextStyles.smallTextStyle),
                        ],
                      ),
                      verticalSpace(.4.h),

                      /// Email Field
                      CustomTextField(
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
                            () => CustomTextField(
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
                      verticalSpace(1.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Confirm Password", style: AppTextStyles.smallTextStyle),
                        ],
                      ),
                      verticalSpace(.4.h),

                      /// PASSWORD FIELD (Reactive)
                      Obx(
                            () => CustomTextField(
                          hintText: "Re Enter Your Password",
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


                      verticalSpace(3.h),

                      /// LOGIN BUTTON
                      CustomButton(height: 5.5.h, title: "Sign", onTap: () {}),


                      verticalSpace(2.h),
                     GestureDetector(
                       onTap: (){
                         Get.to((LoginScreen()));
                       },
                       child:  Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Text(
                             "I already have an account? ",
                             style: AppTextStyles.smallTextStyle.copyWith(
                               color: AppColors.borderGrey,
                             ),
                           ),
                           Text(
                             "Sign In",
                             style: AppTextStyles.greenBoldTextStyle.copyWith(
                               fontSize: 16.5.sp,
                             ),
                           ),
                         ],
                       ),
                     )
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

