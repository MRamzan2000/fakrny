import 'package:fakrny/utils/app_colors.dart';
import 'package:fakrny/utils/app_text_styles.dart';
import 'package:fakrny/utils/my_shared_pref.dart';
import 'package:fakrny/utils/popups.dart';
import 'package:fakrny/views/reused_widgets/custom_switch.dart';
import 'package:fakrny/views/reused_widgets/horizontal_space.dart';
import 'package:fakrny/views/reused_widgets/reused_able_appbar.dart';
import 'package:fakrny/views/reused_widgets/vertical_space.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'auth_screens/change_password_screen.dart' show ChangePasswordScreen;
import 'notification_type_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Center(
          child: Text(
            "select_language".tr,
            style: AppTextStyles.boldTextStyle.copyWith(
              fontSize: 22.sp,
              color: AppColors.primaryColor,
            ),
          ),
        ),
        contentPadding: EdgeInsets.zero,
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _languageOption(
                title: "English",
                flag: "US",
                locale: const Locale('en', 'US'),
              ),
              _languageOption(
                title: "العربية",
                flag: "SA",
                locale: const Locale('ar', 'SA'),
              ),
              verticalSpace(2.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _languageOption({
    required String title,
    required String flag,
    required Locale locale,
  }) {
    bool isSelected = Get.locale?.languageCode == locale.languageCode;

    return InkWell(
      onTap: () async{
        Get.updateLocale(locale);
        await SharedPrefHelper.saveLanguage(locale);
        Get.back();
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.5.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor.withOpacity(0.12) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : Colors.grey.shade300,
            width: isSelected ? 2.5 : 1.5,
          ),
        ),
        child: Row(
          children: [
            Text(flag, style: const TextStyle(fontSize: 32)),
            SizedBox(width: 4.w),
            Text(
              title,
              style: AppTextStyles.semiBoldTextStyle.copyWith(
                fontSize: 18.sp,
                color: isSelected ? AppColors.primaryColor : AppColors.textColor,
              ),
            ),
            const Spacer(),
            if (isSelected)
              Icon(Icons.check_circle, color: AppColors.primaryColor, size: 26.sp),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            appBar(title: "settings".tr),

            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                child: Column(
                  children: [
                    _settingsTile(
                      title: "App_notifications".tr,
                      trailing: SwitchButton(value: true, onChanged: (_) {}),
                    ),
                    _settingsTile(
                      title: "Notification_type".tr,
                      onTap: () => Get.to(() => const NotificationTypeScreen()),
                    ),
                    _settingsTile(
                      title: "Language".tr,
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            Get.locale?.languageCode == 'ar' ? "العربية" : "English",
                            style: AppTextStyles.semiBoldTextStyle.copyWith(
                              fontSize: 17.sp,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          horizontalSpace( 2.w),
                          Icon(Icons.arrow_forward_ios, size: 16.sp, color: Colors.black54),
                        ],
                      ),
                      onTap: () => _showLanguageDialog(context),
                    ),
                    _settingsTile(
                      title: "Change_password".tr,
                      onTap: () => Get.to(() => ChangePasswordScreen()),
                    ),
                    _settingsTile(
                      title: "Delete_account".tr,
                      onTap: () => showDeleteAccountDialog(context),
                      textColor: Colors.red,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _settingsTile({
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
    Color? textColor,
  }) {
    return Card(
      elevation: 0,
      color: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0.5.h),
        title: Text(
          title,
          style: AppTextStyles.semiBoldTextStyle.copyWith(
            color: textColor ?? AppColors.textColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: trailing ??
            Icon(Icons.arrow_forward_ios, size: 18.sp, color: Colors.black54),
        onTap: onTap,
      ),
    );
  }
}