import 'package:fakrny/utils/app_colors.dart';
import 'package:fakrny/utils/app_text_styles.dart';
import 'package:fakrny/utils/popups.dart';
import 'package:fakrny/views/reused_widgets/elevated_button.dart';
import 'package:fakrny/views/reused_widgets/reused_able_appbar.dart';
import 'package:fakrny/views/reused_widgets/vertical_space.dart';
import 'package:fakrny/views/screens/privacy_policy_screen.dart';
import 'package:fakrny/views/screens/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            appBar(title: "profile".tr),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 3.h),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.appBarColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 5.h,
                          backgroundImage: const NetworkImage(
                            "https://randomuser.me/api/portraits/men/46.jpg",
                          ),
                        ),
                        verticalSpace(.6.h),
                        // Name dynamic hoga, agar controller se aaye to .tr nahi lagega
                        Text(
                          "Mohsin", // agar user ka name Arabic mein bhi show karna hai to controller se lo
                          style: AppTextStyles.semiBoldTextStyle.copyWith(
                            color: AppColors.textColor,
                            fontSize: 18.sp,
                          ),
                        ),
                        verticalSpace(1.h),
                        CustomButton(
                          height: 3.5.h,
                          width: 24.w,
                          title: "edit".tr,
                          onTap: () => showEditProfileDialog(context),
                        ),
                      ],
                    ),
                  ),

                  verticalSpace(2.h),

                  _buildMenuItem(
                    icon: Icons.settings_outlined,
                    title: "settings".tr,
                    onTap: () => Get.to(() => const SettingsScreen()),
                  ),
                  verticalSpace(1.5.h),

                  _buildMenuItem(
                    icon: Icons.privacy_tip_outlined,
                    title: "privacy_policy".tr,
                    onTap: () => Get.to(() => PrivacyPolicyScreen()),
                  ),
                  verticalSpace(1.5.h),

                  _buildMenuItem(
                    icon: Icons.star_border,
                    title: "rate_us".tr,
                    onTap: () {},
                  ),
                  verticalSpace(1.5.h),

                  _buildMenuItem(
                    icon: Icons.share_outlined,
                    title: "share".tr,
                    onTap: () {},
                  ),
                  verticalSpace(1.5.h),

                  _buildMenuItem(
                    icon: Icons.logout,
                    title: "log_out".tr,
                    onTap: () => showLogoutDialog(context),
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 4.w),
      leading: Icon(icon, color: color ?? AppColors.primaryColor, size: 3.4.h),
      title: Text(
        title,
        style: AppTextStyles.semiBoldTextStyle.copyWith(
          color: AppColors.textColor,
          fontSize: 15.5.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black54),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      tileColor: AppColors.appBarColor,
      onTap: onTap,
    );
  }
}