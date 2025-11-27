import 'package:fakrny/utils/app_colors.dart';
import 'package:fakrny/utils/app_text_styles.dart';
import 'package:fakrny/utils/popups.dart';
import 'package:fakrny/views/reused_widgets/custom_switch.dart';
import 'package:fakrny/views/reused_widgets/reused_able_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'auth_screens/change_password_screen.dart' show ChangePasswordScreen;
import 'notification_type_screen.dart';
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            appBar(title: "Settings"),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
              child: Column(
                children: [
                  _settingsTile(
                    title: "App Notifications",
                    trailing:SwitchButton(value: true, onChanged: (_){}),
                  ),
                  _settingsTile(title: "Notification Type", onTap: () => Get.to(() => const NotificationTypeScreen())),
                  _settingsTile(title: "Change Password", onTap: () {
                    Get.to(()=>ChangePasswordScreen());
                  }),
                  _settingsTile(title: "Delete Account", onTap: () {
                    showDeleteAccountDialog(context);
                  }, textColor: Colors.red),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _settingsTile({required String title, Widget? trailing, VoidCallback? onTap, Color? textColor}) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 4.w),
      title: Text(title, style: AppTextStyles.semiBoldTextStyle.copyWith(
        color: AppColors.textColor,
        fontSize: 15.5.sp,
        fontWeight: FontWeight.w500,
      ),),
      trailing: trailing ??  Icon(Icons.arrow_forward_ios, size: 18.sp, color: Colors.black54),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      onTap: onTap,
    );
  }
}