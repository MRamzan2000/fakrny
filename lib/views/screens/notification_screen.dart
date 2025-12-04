import 'package:fakrny/utils/app_colors.dart';
import 'package:fakrny/views/reused_widgets/reused_able_appbar.dart';
import 'package:fakrny/views/reused_widgets/vertical_space.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  // Demo notifications – ab Arabic mein bhi dikhega
  final List<Map<String, String>> notifications = const [
    {
      "type": "stock_ending",
      "title": "stock_ending_message",
      "time": "10:23AM",
    },
    {
      "type": "reminder",
      "title": "reminder_message",
      "time": "09:15AM",
    },
    {
      "type": "reminder",
      "title": "dose_reminder_message",
      "time": "02:00PM",
    },
    {
      "type": "general",
      "title": "general_notification",
      "time": "Yesterday",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          child: Column(
            children: [
              appBar(title: "notifications".tr),
              verticalSpace(2.h),

              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  itemCount: notifications.length,
                  separatorBuilder: (_, __) => Divider(height: 1.h, color: Colors.grey[300]),
                  itemBuilder: (context, index) {
                    final noti = notifications[index];
                    final isStockEnding = noti["type"] == "stock_ending";

                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Type Label (Stock Ending = Red, Others = Green)
                              Text(
                                isStockEnding ? "stock_ending".tr : noti["type"]!.tr,
                                style: TextStyle(
                                  color: isStockEnding ? Colors.red : AppColors.primaryColor,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                noti["time"]!,
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 15.sp,
                                ),
                              ),
                            ],
                          ),
                          verticalSpace(.5.h),
                          Text(
                            noti["title"]!.tr,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.black87,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}