import 'dart:async';
import 'package:fakrny/utils/app_colors.dart';
import 'package:fakrny/utils/app_text_styles.dart';
import 'package:fakrny/utils/my_shared_pref.dart';
import 'package:fakrny/views/reused_widgets/vertical_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'bottom_navigation_bar.dart';
import 'on_boarding_pages/on_boarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    final isLogin = SharedPrefHelper.isLoggedIn();
    Timer(const Duration(seconds: 5), () {
      if(isLogin){
        Get.offAll(()=>BottomBar());
      }else{
        Get.to(() => OnBoardingScreen());
      }

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
            const Spacer(),
            Transform.scale(
              scale: .16.h,
              child: SvgPicture.asset("assets/icons/app_logo.svg"),
            ),
            verticalSpace(1.5.h),
            Text("app_name".tr, style: AppTextStyles.boldTextStyle),
            const Spacer(),
            Text(
              "splash_subtitle".tr,
              style: AppTextStyles.semiBoldTextStyle,
              textAlign: TextAlign.center,
            ),
            verticalSpace(9.h),
          ],
        ),
      ),
    );
  }
}