import 'package:fakrny/utils/app_colors.dart';
import 'package:fakrny/utils/app_text_styles.dart';
import 'package:fakrny/views/reused_widgets/horizontal_space.dart';
import 'package:fakrny/views/reused_widgets/reused_able_appbar.dart';
import 'package:fakrny/views/reused_widgets/vertical_space.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NotificationTypeScreen extends StatefulWidget {
  const NotificationTypeScreen({super.key});

  @override
  State<NotificationTypeScreen> createState() => _NotificationTypeScreenState();
}

enum NotificationType { sound, silent, custom }

class _NotificationTypeScreenState extends State<NotificationTypeScreen> {
  NotificationType _selected = NotificationType.sound;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            appBar(title: "Notification Type"),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                children: [
                  verticalSpace(2.h),
                  _selected == NotificationType.sound
                      ? Column(
                          children: [
                            _optionTile(
                              type: NotificationType.sound,
                              title: "Sound Alert",
                              subtitle:
                                  "Plays the standard notification sound.",
                              icon: Icons.notifications_active,
                            ),
                            verticalSpace(1.h),
                            selectedTile(
                              title: "Default app audio",
                              subtitle: "It’s time to take your medicine.",
                              icon: Icons.play_arrow_rounded,
                            ),
                          ],
                        )
                      : _optionTile(
                          type: NotificationType.sound,
                          title: "Sound Alert",
                          subtitle: "Plays the standard notification sound.",
                          icon: Icons.notifications_active,
                        ),
                  verticalSpace(.5.h),
                  Divider(),
                  verticalSpace(1.h),

                  _optionTile(
                    type: NotificationType.silent,
                    title: "Silent Alert",
                    subtitle: "No sound. Notification will display only.",
                    icon: Icons.volume_off,
                  ),
                  verticalSpace(.5.h),
                  Divider(),
                  verticalSpace(1.h),

                  _selected == NotificationType.custom? Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _optionTile(
                        type: NotificationType.custom,
                        title: "Custom Ringtone",
                        subtitle: "Choose a ringtone from your device.",
                        icon: Icons.music_note,
                      ),
                      verticalSpace(1.h),
                      Container(
                        margin: EdgeInsets.only(left: 11.w),
                        padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: .3.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.px),
                          border: Border.all(
                              color: AppColors.primaryColor
                          ),
                        ),
                        child: Text("Select ringtone",style: AppTextStyles.smallTextStyle.copyWith(
                          color: AppColors.primaryColor,
                          fontSize: 12.px
                        ),)
                        ,
                      )

                    ],
                  ): _optionTile(
                    type: NotificationType.custom,
                    title: "Custom Ringtone",
                    subtitle: "Choose a ringtone from your device.",
                    icon: Icons.music_note,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _optionTile({
    required NotificationType type,
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: () => setState(() => _selected = type),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Radio(
            value: type,
            groupValue: _selected,
            onChanged: (_) => setState(() => _selected = type),
            activeColor: Colors.green,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.semiBoldTextStyle.copyWith(
                  color: AppColors.textColor,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              verticalSpace( .3.h),

              Text(
                subtitle,
                style: AppTextStyles.regularTextStyle.copyWith(
                  color: Colors.grey[600],
                  fontSize: 13.5.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget selectedTile({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return GestureDetector(
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 2.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
              Icon(Icons.add_alert_rounded,size: 3.h,color: AppColors.primaryColor,),
              horizontalSpace(3.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.semiBoldTextStyle.copyWith(
                      color: AppColors.textColor,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  verticalSpace( .3.h),

                  Text(
                    subtitle,
                    style: AppTextStyles.regularTextStyle.copyWith(
                      color: Colors.grey[600],
                      fontSize: 13.5.sp,
                    ),
                  ),
                ],
              ),
            ],),
            Icon(icon,size: 4.h,color: AppColors.primaryColor,)
          ],
        ),
      ),
    );
  }
}
