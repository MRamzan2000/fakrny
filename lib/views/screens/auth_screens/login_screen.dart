import 'package:fakrny/utils/app_colors.dart';
import 'package:fakrny/utils/app_text_styles.dart';
import 'package:fakrny/views/reused_widgets/elevated_button.dart';
import 'package:fakrny/views/reused_widgets/horizontal_space.dart';
import 'package:fakrny/views/reused_widgets/text_filed.dart';
import 'package:fakrny/views/reused_widgets/vertical_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();
  bool remember = false;
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,

      body: Stack(
        children: [
          Positioned(
            top: 17.h,
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
                  )
                ],
              ),

              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Sign In",
                      style: AppTextStyles.greenBoldTextStyle
                    ),
                    verticalSpace(0.4.h),

                    Text(
                      "Sign in with Email",
                        style: AppTextStyles.smallTextStyle
                    ),

                    verticalSpace(2.h),
                    Row(mainAxisAlignment: MainAxisAlignment.start,
                      children: [Text("Email",
                        style: AppTextStyles.smallTextStyle,
                      )],
                    ),
                    verticalSpace(.4.h),

                    /// Email Field
                    CustomTextField(
                      hintText: "My Email",
                      controller: emailCtrl,
                      iconPath: "assets/icons/email.svg",
                    ),
                    verticalSpace(1.h),
                    Row(mainAxisAlignment: MainAxisAlignment.start,
                      children: [Text("Password",
                        style: AppTextStyles.smallTextStyle,
                      )],
                    ),
                    verticalSpace(.4.h),
                    /// Password Field
                    CustomTextField(
                      hintText: "My Password",
                      controller: passCtrl,
                      iconPath: "assets/icons/password.svg",
                      isPassword: true,
                      obscureText: obscure,
                      suffixIcon:obscure ?SvgPicture.asset("assets/icons/eye_off.svg"):SvgPicture.asset("assets/icons/eye_on.svg") ,
                      onSuffixTap: () {
                        setState(() => obscure = !obscure);
                      },
                    ),

                    verticalSpace(2.h),

                    /// Remember Me + Forgot
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 2.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () =>
                                    setState(() => remember = !remember),
                                child: Container(
                                  height: 18.sp,
                                  width: 18.sp,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: AppColors.primaryColor,
                                      width: 2,
                                    ),
                                    color: remember
                                        ? AppColors.secondaryColor
                                        : AppColors.white,
                                  ),
                                  child: remember
                                      ? Icon(
                                    Icons.check,
                                    size: 16.sp,
                                    color:remember?AppColors.primaryColor: AppColors.white,
                                  )
                                      : null,
                                ),
                              ),
                              horizontalSpace(1.8.w),
                              Text(
                                "Remember Me",
                                style: AppTextStyles.smallTextStyle
                              ),
                            ],
                          ),

                          Text(
                            "Forgot Password",
                            style: AppTextStyles.smallTextStyle.copyWith(

                            )
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 3.h),

                    /// LOGIN Button
                    CustomButton(
                      title: "Login",
                      onTap: () {},
                    ),

                    SizedBox(height: 3.h),

                    /// OR Divider
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.grey.shade300,
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: Text(
                            "OR",
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.grey.shade300,
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 3.h),

                    /// Phone Login Button (Outline)
                    CustomButton(
                      title: "Sign In With Phone",
                      onTap: () {},
                      isGradient: false,
                      color: const Color(0xffF4F8FB),
                      border: Border.all(
                        color: const Color(0xff1FB774),
                        width: 2,
                      ),
                      textColor: AppColors.primaryColor,
                    ),

                    SizedBox(height: 2.5.h),

                    /// Sign Up Text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "I don’t have an account? ",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
