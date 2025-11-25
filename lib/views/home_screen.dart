import 'dart:async';
import 'package:fakrny/utils/app_colors.dart';
import 'package:fakrny/utils/app_text_styles.dart';
import 'package:fakrny/utils/second_curved.dart';
import 'package:fakrny/views/reused_widgets/elevated_button.dart';
import 'package:fakrny/views/reused_widgets/vertical_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'screens/medicine/add_medicine_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Timer _timer;
  String currentTime = "";

  @override
  void initState() {
    super.initState();

    // Initial time
    currentTime = _formatTime(DateTime.now());

    // Update every second
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        currentTime = _formatTime(DateTime.now());
      });
    });
  }

  String _formatTime(DateTime t) => DateFormat('mm:ss').format(t);

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 100.h,
        width: 100.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 42.h,
              child: Stack(
                children: [
                  ClipPath(
                    clipper: BottomInsideDeepCurveClipper(),
                    child: Container(
                      height: 38.h,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xff63E4AE), Color(0xff1FB774)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(4.w, 5.h, 4.w, 1.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Text(
                                  "Hey Mohsin!",
                                  style: AppTextStyles.boldTextStyle.copyWith(
                                    color: AppColors.textColor,
                                    fontSize: 20.sp,
                                  ),
                                ),
                                subtitle: Text(
                                  "Welcome !",
                                  style: AppTextStyles.regularTextStyle.copyWith(
                                    color: AppColors.textColor,
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                trailing: Transform.scale(
                                  scale: 1.2,
                                  child: SizedBox(
                                    width: 16.w,
                                    child: SvgPicture.asset(
                                      "assets/icons/notification_icon.svg",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      alignment: Alignment.center,
                      height: 28.h,
                      width: 28.h,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.10),
                            blurRadius: 5,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Container(
                        height: 25.h,
                        width: 25.h,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xffF0F0F0),
                            width: 18.px,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // REAL-TIME CLOCK
                            Text(
                              currentTime,
                              style: AppTextStyles.boldTextStyle.copyWith(
                                color: AppColors.textColor,
                                fontSize: 25.sp,
                              ),
                            ),

                            Text(
                              "AM",
                              style: AppTextStyles.boldTextStyle.copyWith(
                                color: AppColors.textColor,
                                fontSize: 18.sp,
                              ),
                            ),
                            Text(
                              "No Tablet",
                              style: AppTextStyles.boldTextStyle.copyWith(
                                color: AppColors.primaryColor,
                                fontSize: 18.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            verticalSpace(2.h),

            // IMAGE
            SizedBox(
              height: 20.h,
              child: Transform.scale(
                scale: 1.2,
                child: Image.asset(
                  "assets/images/no_medicine.png",
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),

            verticalSpace(2.h),

            Text(
              "No Medications Added",
              style: AppTextStyles.boldTextStyle.copyWith(
                color: AppColors.textColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
              ),
            ),

            Text(
              "If you haven't added a medication, please do so now.",
              style: AppTextStyles.hintTextStyle.copyWith(
                color: AppColors.borderGrey,
                fontSize: 15.sp,
              ),
            ),

            verticalSpace(5.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: CustomButton(
                height: 5.5.h,
                iconPath: "assets/icons/plus.svg",
                title: "Add Medication",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.buttonText,
                ),
                onTap: () {
                  Get.to(()=>AddMedicineScreen());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
