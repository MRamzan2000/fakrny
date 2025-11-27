import 'package:fakrny/utils/app_text_styles.dart';
import 'package:fakrny/views/reused_widgets/elevated_button.dart';
import 'package:fakrny/views/reused_widgets/reused_able_appbar.dart';
import 'package:fakrny/views/reused_widgets/text_filed.dart';
import 'package:fakrny/views/reused_widgets/vertical_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  // Text controllers
  final TextEditingController previousPassword = TextEditingController();
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  // Toggles
  bool obscurePrev = true;
  bool obscureNew = true;
  bool obscureConfirm = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          child: Column(
            children: [
              appBar(title: "Change Password"),
              verticalSpace(4.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Column(
                  children: [
                    // Previous Password
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Previous Password",
                          style: AppTextStyles.smallTextStyle,
                        ),
                      ],
                    ),
                    verticalSpace(.4.h),

                    customTextField(
                      hintText: "Enter Previous Password",
                      controller: previousPassword,
                      iconPath: "assets/icons/password.svg",
                      isPassword: true,
                      obscureText: obscurePrev,
                      suffixIcon: obscurePrev
                          ? SvgPicture.asset("assets/icons/eye_off.svg")
                          : SvgPicture.asset("assets/icons/eye_on.svg"),
                      onSuffixTap: () {
                        setState(() {
                          obscurePrev = !obscurePrev;
                        });
                      },
                    ),

                    verticalSpace(1.6.h),

                    // New Password
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "New Password",
                          style: AppTextStyles.smallTextStyle,
                        ),
                      ],
                    ),
                    verticalSpace(.4.h),

                    customTextField(
                      hintText: "Enter New Password",
                      controller: newPassword,
                      iconPath: "assets/icons/password.svg",
                      isPassword: true,
                      obscureText: obscureNew,
                      suffixIcon: obscureNew
                          ? SvgPicture.asset("assets/icons/eye_off.svg")
                          : SvgPicture.asset("assets/icons/eye_on.svg"),
                      onSuffixTap: () {
                        setState(() {
                          obscureNew = !obscureNew;
                        });
                      },
                    ),

                    verticalSpace(1.6.h),

                    // Confirm Password
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Confirm Password",
                          style: AppTextStyles.smallTextStyle,
                        ),
                      ],
                    ),
                    verticalSpace(.4.h),

                    customTextField(
                      hintText: "Enter Confirm Password",
                      controller: confirmPassword,
                      iconPath: "assets/icons/password.svg",
                      isPassword: true,
                      obscureText: obscureConfirm,
                      suffixIcon: obscureConfirm
                          ? SvgPicture.asset("assets/icons/eye_off.svg")
                          : SvgPicture.asset("assets/icons/eye_on.svg"),
                      onSuffixTap: () {
                        setState(() {
                          obscureConfirm = !obscureConfirm;
                        });
                      },
                    ),

                    verticalSpace(5.h),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: CustomButton(
                        height: 5.5.h,
                        title: "Save",
                        onTap: () {
                          // Submit logic
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
