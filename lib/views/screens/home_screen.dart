// home_screen.dart  →  SIRF UI VERSION (No Logic, No Controller)

import 'package:fakrny/utils/app_colors.dart';
import 'package:fakrny/utils/app_text_styles.dart';
import 'package:fakrny/utils/second_curved.dart';
import 'package:fakrny/views/reused_widgets/elevated_button.dart';
import 'package:fakrny/views/reused_widgets/horizontal_space.dart';
import 'package:fakrny/views/reused_widgets/vertical_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 100.h,
        width: 100.w,
        child: Column(
          children: [
            // TOP SECTION WITH CIRCLE
            _buildTopSection(),

            verticalSpace(3.h),

            // TODAY'S MEDICINES LIST (Dummy Data)
            Expanded(
              child: _buildDummyDoseList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopSection() {
    return SizedBox(
      height: 42.h,
      child: Stack(
        children: [
          // Green Curved Green Header
          ClipPath(
            clipper: BottomInsideDeepCurveClipper(),
            child: Container(
              height: 38.h,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff63E4AE), Color(0xff1FB774)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: EdgeInsets.fromLTRB(4.w, 5.h, 4.w, 1.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User Name
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Hi, Ahmed",
                        style: AppTextStyles.boldTextStyle.copyWith(
                          color: Colors.white,
                          fontSize: 20.sp,
                        ),
                      ),
                      Text(
                        "Good Morning!",
                        style: TextStyle(color: Colors.white70, fontSize: 16.sp),
                      ),
                    ],
                  ),
                  Row(crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Transform.scale(
                        scale: 2,
                        child: SvgPicture.asset("assets/icons/notification_icon.svg", width: 7.w)
                      )
                      ,
                      horizontalSpace(4.w),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.add, color: Colors.white, size: 26),
                      ),
                    ],
                  ),
                  // Icons

                ],
              ),
            ),
          ),

          // Big White Circle with Countdown
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 28.h,
              width: 28.h,
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 20, offset: Offset(0, 10))
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "02:15:47",
                    style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: AppColors.textColor),
                  ),
                  Text(
                    "Paracetamol",
                    style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: AppColors.primaryColor),
                  ),
                  SizedBox(height: 1.h),
                  ElevatedButton(
                    onPressed: () {}, // dummy button
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: Text("Taken", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDummyDoseList() {
    final List<Map<String, String>> dummyDoses = [
      {"name": "Paracetamol", "dose": "500mg • 1 tablet", "time": "08:00 AM", "status": "Taken"},
      {"name": "Amlodipine", "dose": "5mg • 1 tablet", "time": "09:00 AM","status":  "Pending"},
      {"name": "Vitamin D3", "dose": "1000 IU • 1 capsule", "time": "10:00 AM", "status": "Pending"},
      {"name": "Metformin", "dose": "500mg • 1 tablet", "time": "01:00 PM", "status": "Missed"},
      {"name": "Atorvastatin", "dose": "20mg • 1 tablet", "time": "09:00 PM", "status": "Pending"},
    ];

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      itemCount: dummyDoses.length,
      itemBuilder: (context, index) {
        final item = dummyDoses[index];
        final status = item["status"]!;

        Color color = status == "Taken"
            ? Colors.green
            : status == "Missed"
            ? Colors.red
            : Colors.orange;

        IconData icon = status == "Taken"
            ? Icons.check_circle
            : status == "Missed"
            ? Icons.cancel
            : Icons.schedule;

        return Container(
          margin: EdgeInsets.only(bottom: 2.h),
          padding: EdgeInsets.all(3.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12, offset: Offset(0, 6))],
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: color.withOpacity(0.1),
              child: Icon(icon, color: color),
            ),
            title: Text(item["name"]!, style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item["dose"]!, style: TextStyle(color: Colors.grey[700], fontSize: 14.sp)),
                Text(item["time"]!, style: TextStyle(fontSize: 14.sp)),
              ],
            ),
            trailing: Text(
              status,
              style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 13.sp),
            ),
          ),
        );
      },
    );
  }
}