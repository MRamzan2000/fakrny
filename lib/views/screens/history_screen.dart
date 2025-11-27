import 'package:fakrny/utils/app_colors.dart';
import 'package:fakrny/utils/app_text_styles.dart';
import 'package:fakrny/views/reused_widgets/vertical_space.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  int selectedIndex = 3; // F 25 (demo)

  final days = ["M", "T", "W", "T", "F", "S", "S"];
  final dates = [21, 22, 23, 24, 25, 26, 27];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(2.h),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "History",
                    style: AppTextStyles.boldTextStyle.copyWith(
                        color: AppColors.textColor,
                        fontSize: 19.sp,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ],),
              verticalSpace(2.h),


              /// TODAY DATE
              Text(
                "Today, July 25",
                style:  AppTextStyles.boldTextStyle.copyWith(
              color: AppColors.textColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500
              ),
              ),

              verticalSpace(2.h),

              /// HORIZONTAL 7-DAY SELECTOR
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.chevron_left),

                  ...List.generate(days.length, (index) {
                    final isSelected = index == selectedIndex;

                    return InkWell(
                      onTap: () {
                        setState(() => selectedIndex = index);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 1.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: isSelected
                              ? Border.all(color: AppColors.primaryColor, width: 2)
                              : null,
                          color: isSelected ? Colors.green.withOpacity(0.1) : null,
                        ),
                        child: Column(
                          children: [
                            Text(
                              days[index],
                              style: AppTextStyles.smallTextStyle.copyWith(
                                color:
                                isSelected ? AppColors.primaryColor : AppColors.textColor,
                              )

                            ),
                            SizedBox(height: 0.5.h),
                            Text(
                              dates[index].toString(),
                              style:  AppTextStyles.smallTextStyle.copyWith(
                                color:
                                isSelected ? AppColors.primaryColor : AppColors.textColor,
                              )
                            ),
                          ],
                        ),
                      ),
                    );
                  }),

                  const Icon(Icons.chevron_right),
                ],
              ),

              verticalSpace( 3.h),

              /// SECTION TITLE
              Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                    child: Text(
                      "Medicine taken",
                      style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Expanded(child: Divider()),
                ],
              ),

              SizedBox(height: 2.h),

              /// MEDICINE LIST
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    medicineTile(
                      name: "Risek",
                      dose: "20mg | 1 Capsule",
                      time: "09:30 AM",
                      asset: "assets/images/risek.png",
                    ),
                    verticalSpace(1.h),
                    Divider(),
                    verticalSpace(1.h),
                    medicineTile(
                      name: "Captopril",
                      dose: "20mg | 1 Tablet",
                      time: "09:30 AM",
                      asset: "assets/images/captopril.png",
                    ),
                    verticalSpace(1.h),
                    Divider(),
                    verticalSpace(1.h),
                    medicineTile(
                      name: "Risek",
                      dose: "20mg | 1 Capsule",
                      time: "03:00 PM",
                      asset: "assets/images/risek.png",
                    ),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// ---- MEDICINE TILE ----
  Widget medicineTile({
    required String name,
    required String dose,
    required String time,
    required String asset,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// IMAGE
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: 8.h,
            width: 26.w,
            padding: EdgeInsets.all(5),
            color: const Color(0xffF6F6F6),
            child: Image.asset(asset, fit: BoxFit.contain),
          ),
        ),

        SizedBox(width: 4.w),

        /// TEXT
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style:
              TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 0.5.h),
            Text(
              dose,
              style: TextStyle(fontSize: 14.sp, color: Colors.black87),
            ),
            Text(
              "Taken | $time",
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.green,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        )
      ],
    );
  }
}
