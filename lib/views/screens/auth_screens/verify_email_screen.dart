import 'package:fakrny/controllers/auth_controller.dart';
import 'package:fakrny/utils/app_colors.dart';
import 'package:fakrny/utils/app_text_styles.dart';
import 'package:fakrny/views/reused_widgets/elevated_button.dart';
import 'package:fakrny/views/reused_widgets/vertical_space.dart';
import 'package:fakrny/views/screens/auth_screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';
class VerifyEmailScreen extends StatelessWidget {
  VerifyEmailScreen({super.key});
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
                        verticalSpace(1.h),
                        Text("Verify your email", style: AppTextStyles.boldTextStyle.copyWith(
                          color: AppColors.black,

                        )),
                        verticalSpace(0.4.h),

                        Text("A verification code has been sent to\n example@gmail.com, check your email to\n activate your account.", style: AppTextStyles.smallTextStyle,
                          textAlign: TextAlign.center,),
                        verticalSpace(3.h),

                        PinCodeTextField(
                          appContext: context,
                          length: 6,
                          obscureText: false,
                          animationType: AnimationType.scale,
                          keyboardType: TextInputType.number,
                          textStyle: AppTextStyles.boldTextStyle.copyWith(fontSize: 20.sp,
                              color: AppColors.textColor),
                          cursorColor: AppColors.primaryColor,

                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(10),
                            fieldHeight: 7.h,
                            fieldWidth: 12.w,
                            inactiveColor: Colors.grey.shade300,
                            activeColor: AppColors.primaryColor,
                            selectedColor: AppColors.primaryColor,
                          ),

                          onChanged: (value) {},
                        ),

                        verticalSpace(6.h),


                        CustomButton(height: 5.5.h, title: "Submit", onTap: () {
                          Get.to(()=>LoginScreen());
                        }),

                        verticalSpace(2.h),




                      ],
                    ),
                  ),
                ),
              ),
              Positioned(bottom: 42.h,
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
