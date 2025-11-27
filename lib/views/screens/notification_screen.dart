import 'package:fakrny/utils/app_colors.dart';
import 'package:fakrny/views/reused_widgets/reused_able_appbar.dart';
import 'package:fakrny/views/reused_widgets/vertical_space.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  final List<Map<String, String>> notifications = const [
    {
      "type": "Stock Ending",
      "title": "Lorem ipsum dolor sit amet, consectetur elit.",
      "time": "10:23AM",
    },
    {
      "type": "Heading",
      "title": "Lorem ipsum dolor sit amet, consectetur elit.",
      "time": "10:23AM",
    },
    {
      "type": "Heading",
      "title": "Lorem ipsum dolor sit amet, consectetur elit.",
      "time": "10:23AM",
    },
    {
      "type": "Heading",
      "title": "Lorem ipsum dolor sit amet, consectetur elit.",
      "time": "10:23AM",
    },
    {
      "type": "Heading",
      "title": "Lorem ipsum dolor sit amet, consectetur elit.",
      "time": "10:23AM",
    },
    {
      "type": "Heading",
      "title": "Lorem ipsum dolor sit amet, consectetur elit.",
      "time": "10:23AM",
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
              appBar(title: "Notification"),
              verticalSpace(2.h),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0),
                  itemCount: notifications.length,
                  separatorBuilder: (_, __) =>
                      Divider(height: 1.h, color: Colors.grey[300]),
                  itemBuilder: (context, index) {
                    final noti = notifications[index];
                    final isStockEnding = noti["type"] == "Stock Ending";

                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (isStockEnding)
                                Text(
                                  "Stock Ending",
                                  style:TextStyle(
                                    color: Colors.red,
                                    fontSize: 14.sp,
                                  ),
                                )
                              else
                                Text(
                                  noti["type"] == "Stock Ending"
                                      ? ""
                                      : "Heading",
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              if (isStockEnding) SizedBox(width: 3.w),
                              Text(
                                noti["time"]!,
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                          verticalSpace(.5.h),
                          Text(
                            noti["title"]!,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.black87,
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
