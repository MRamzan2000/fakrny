import 'package:fakrny/controllers/onboarding_controller.dart';
import 'package:fakrny/utils/app_colors.dart';
import 'package:fakrny/utils/app_text_styles.dart';
import 'package:fakrny/views/reused_widgets/vertical_space.dart';
import 'package:fakrny/views/screens/on_boarding_pages/onboarding_page_1.dart';
import 'package:fakrny/views/screens/on_boarding_pages/onboarding_page_2.dart';
import 'package:fakrny/views/screens/on_boarding_pages/onboarding_page_3.dart';
import 'package:fakrny/views/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({super.key});

  final OnBoardingController onboardingController = Get.put(
    OnBoardingController(),
  );

  final pages = const [OnBoardingPage1(), OnBoardingPage2(), OnBoardingPage3()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 72.h,
              width: 100.w,
              child: PageView(
                controller: onboardingController.pageController,
                onPageChanged: (i) =>
                    onboardingController.currentPage.value = i,
                children: pages,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 1.5.h),
              child: SmoothPageIndicator(
                controller: onboardingController.pageController,
                count: 3,
                effect: ExpandingDotsEffect(
                  dotColor: AppColors.grey,
                  activeDotColor: AppColors.primaryColor,
                  dotHeight: 1.6.h,
                  dotWidth: 1.6.h,
                  expansionFactor: 3,
                  spacing: 1.w,
                ),
              ),
            ),

            const Spacer(),
            Padding(
              padding: EdgeInsets.only(left: 6.w),
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(() => WelcomeScreen());
                      },
                      child: Text(
                        "Skip",
                        style: AppTextStyles.smallTextStyle.copyWith(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (onboardingController.currentPage.value == 2) {
                          Get.to(() => WelcomeScreen());
                        } else {
                          onboardingController.nextPage();
                        }
                      },
                      child: SvgPicture.asset(
                        onboardingController.currentPage.value == 2
                            ? "assets/icons/get_started.svg"
                            : "assets/icons/next.svg",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            verticalSpace(5.h), // responsive spacing
          ],
        ),
      ),
    );
  }
}
