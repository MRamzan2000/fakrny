import 'package:fakrny/utils/app_colors.dart';
import 'package:fakrny/utils/app_text_styles.dart';
import 'package:fakrny/views/reused_widgets/reused_able_appbar.dart';
import 'package:fakrny/views/reused_widgets/vertical_space.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            appBar(title: "Privacy Policy"),

            /// Page Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                child: Container(
                  padding: EdgeInsets.all(3.h),
                  decoration: BoxDecoration(
                    color: AppColors.appBarColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        "Privacy Policy",
                        style: AppTextStyles.semiBoldTextStyle.copyWith(
                          fontSize: 19.sp,
                          color: AppColors.textColor,
                        ),
                      ),

                      verticalSpace(2.h),

                      _section(
                        title: "1. Information We Collect",
                        body:
                        "We collect personal information such as your name, email, and device data to provide a better user experience.",
                      ),

                      verticalSpace(2.h),

                      _section(
                        title: "2. How We Use Information",
                        body:
                        "Your information is used to improve app performance, secure your account, and enhance your overall usage.",
                      ),

                      verticalSpace(2.h),

                      _section(
                        title: "3. Data Protection",
                        body:
                        "We ensure your data is protected using encryption and secure technologies. We do not share your data with third parties without consent.",
                      ),

                      verticalSpace(2.h),

                      _section(
                        title: "4. Cookies & Tracking",
                        body:
                        "We may use cookies to improve app functionality and personalize your experience.",
                      ),

                      verticalSpace(2.h),

                      _section(
                        title: "5. Your Choices",
                        body:
                        "You can review, update, or delete your personal data anytime from the settings menu.",
                      ),

                      verticalSpace(3.h),

                      Text(
                        "If you have any questions, feel free to contact our support team.",
                        style: AppTextStyles.regularTextStyle.copyWith(
                          fontSize: 14.5.sp,
                          color: AppColors.textColor.withOpacity(0.9),
                        ),
                      ),

                      verticalSpace(3.h),
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

  /// Reusable Section Widget
  Widget _section({required String title, required String body}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.semiBoldTextStyle.copyWith(
            fontSize: 16.sp,
            color: AppColors.primaryColor,
          ),
        ),
        verticalSpace(0.8.h),
        Text(
          body,
          style: AppTextStyles.regularTextStyle.copyWith(
            fontSize: 14.sp,
            height: 1.4,
            color: AppColors.textColor.withOpacity(0.85),
          ),
        ),
      ],
    );
  }
}
