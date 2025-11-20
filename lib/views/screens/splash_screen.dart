import 'dart:async';

import 'package:fakrny/utils/app_colors.dart';
import 'package:fakrny/utils/app_text_styles.dart';
import 'package:fakrny/views/reused_widgets/vertical_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'on_boarding_pages/on_boarding_screen.dart' show OnBoardingScreen;
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), (){
      Get.to(()=>OnBoardingScreen());
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            verticalSpace(6.h),
            Spacer(),
            Transform.scale(
              scale: .16.h,
              child: SvgPicture.asset("assets/icons/app_logo.svg"),
            ),
            verticalSpace(1.5.h),
            Text("Fakrny", style: AppTextStyles.boldTextStyle),
            Spacer(),
            Text(
              "Your Smart Partner for Timely Medication",
              style: AppTextStyles.semiBoldTextStyle,
            ),
            verticalSpace(6.h),
          ],
        ),
      ),
    );
  }
}
