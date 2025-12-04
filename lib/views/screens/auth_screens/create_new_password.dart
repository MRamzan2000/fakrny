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

class CreateNewPassword extends StatefulWidget {
  const CreateNewPassword({super.key});

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  final AuthController controller = Get.put(AuthController());
  final TextEditingController newPasswordCtrl = TextEditingController();
  final TextEditingController confirmPasswordCtrl = TextEditingController();
  final RxBool obscure = true.obs;

  void toggleObscure() => obscure.value = !obscure.value;

  @override
  void dispose() {
    newPasswordCtrl.dispose();
    confirmPasswordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Stack(
        children: [
          // Background + logo
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/blur_bg.png"),
                fit: BoxFit.fitWidth,
              ),
            ),
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
          ),

          // Top logo + app name
          Positioned(
            top: 20.h,
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

          // Main card
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
                    Text(
                      "set_new_password_title".tr,
                      style: AppTextStyles.boldTextStyle.copyWith(
                        color: AppColors.black,
                        fontSize: 22.sp,
                      ),
                    ),
                    verticalSpace(0.4.h),
                    Text(
                      "set_new_password_desc".tr,
                      style: AppTextStyles.smallTextStyle.copyWith(
                        fontSize: 16.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    verticalSpace(3.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("password".tr, style: AppTextStyles.smallTextStyle),
                      ],
                    ),
                    verticalSpace(.4.h),

                    Obx(
                          () => customTextField(
                        hintText: "hint_new_password".tr,
                        controller: newPasswordCtrl,
                        iconPath: "assets/icons/password.svg",
                        isPassword: true,
                        obscureText: obscure.value,
                        suffixIcon: obscure.value
                            ? SvgPicture.asset("assets/icons/eye_off.svg")
                            : SvgPicture.asset("assets/icons/eye_on.svg"),
                        onSuffixTap: toggleObscure,
                      ),
                    ),
                    verticalSpace(1.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("confirm_password".tr, style: AppTextStyles.smallTextStyle),
                      ],
                    ),
                    verticalSpace(.4.h),

                    Obx(
                          () => customTextField(
                        hintText: "hint_confirm_password".tr,
                        controller: confirmPasswordCtrl,
                        iconPath: "assets/icons/password.svg",
                        isPassword: true,
                        obscureText: obscure.value,
                        suffixIcon: obscure.value
                            ? SvgPicture.asset("assets/icons/eye_off.svg")
                            : SvgPicture.asset("assets/icons/eye_on.svg"),
                        onSuffixTap: toggleObscure,
                      ),
                    ),
                    verticalSpace(6.h),

                    CustomButton(
                      height: 5.5.h,
                      title: "submit".tr,
                      onTap: () {
                        Get.to(() => PasswordUpdate());
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
            bottom: 50.h,
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
    );
  }
}
