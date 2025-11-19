import 'package:fakrny/controllers/onboarding_controller.dart';
import 'package:fakrny/utils/app_colors.dart';
import 'package:fakrny/utils/app_text_styles.dart';
import 'package:fakrny/views/reused_widgets/vertical_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final OnBoardingController onboardingController = Get.put(
    OnBoardingController(),
  );

  final List<String> onBoardImages = [
    "assets/images/onboarding_one.png",
    "assets/images/onboarding_two.png",
    "assets/images/onboarding_three.png",
  ];


  final List<String> onBoardingEntitlementText = ["Smart", "Easy", "Track"];
  final List<String> onBoardingHeadingText = [
    "Never Miss a Dose Again",
    "Add by Voice or Photo",
    "Stay on Track",
  ];
  final List<String> onBoardingText = [
    "Get smart alerts before or after meals —\n always on time, every time.",
    "Speak or snap — AI detects your medicine\n name, dosage, and schedule automatically.",
    "Visual dashboards show your progress,\n streaks, and missed doses — all in one place.",
  ];

  @override
  void dispose() {
    onboardingController.pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          children: [
          Expanded(child:   PageView.builder(
            controller: onboardingController.pageController,
            itemCount: onBoardImages.length,
            onPageChanged: (index) {
              onboardingController.currentPage.value = index + 1;
            },
            itemBuilder: (context, pageIndex) {
              return Column(
                children: [
                  verticalSpace(onboardingController.currentPage.value == 1?6.h:18.h),
                 Container(
                   height: 38.h,
                   width: double.infinity,
                   color: AppColors.primaryColor,
                   child:  Image.asset(onBoardImages[pageIndex],fit: BoxFit.fill,),
                 ),
                  Text(
                    onBoardingEntitlementText[pageIndex],
                    style: AppTextStyles.boldTextStyle.copyWith(
                      fontSize: 19.sp,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  verticalSpace(.4.h),
                  Text(
                    onBoardingHeadingText[pageIndex],
                    style: AppTextStyles.semiBoldTextStyle.copyWith(
                      fontSize: 20.sp,
                      color: AppColors.black,
                    ),
                  ),
                  verticalSpace(1.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Text(
                      onBoardingText[pageIndex],
                      style: AppTextStyles.smallTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  verticalSpace(3.h),
                  Padding(
                    padding: EdgeInsets.only(right: 3.w),
                    child: SmoothPageIndicator(
                      controller: onboardingController.pageController,
                      count: onBoardImages.length,
                      axisDirection: Axis.horizontal,
                      effect: ExpandingDotsEffect(
                        dotColor: AppColors.grey,
                        activeDotColor: AppColors.primaryColor,
                        dotHeight: 1.6.h,
                        dotWidth: 1.6.h,
                        expansionFactor: .5.w,
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              );
            },
          ),),
            Padding(
              padding: EdgeInsets.only(left: 6.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Skip",
                    style: AppTextStyles.smallTextStyle.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                  Obx(()=> InkWell(
                    onTap: () {
                      if (onboardingController.currentPage.value == onBoardImages.length) {
                      } else {
                        onboardingController.nextPage();
                      }
                    },
                    child:onboardingController.currentPage.value == 2?SvgPicture.asset("assets/icons/get_started.svg"): SvgPicture.asset("assets/icons/next.svg"),
                  ),)
                ],
              ),
            ),
            verticalSpace(6.h),
          ],
        ),
      ),
    );
  }
}
