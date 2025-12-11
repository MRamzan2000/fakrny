import 'dart:io';  // For File
import 'package:fakrny/controllers/user_controller.dart';
import 'package:fakrny/models/user_model.dart';
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
    final UserController userController = Get.find<UserController>();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            appBar(title: "profile".tr),
            Expanded(
              child: Obx(() {
                final UserModel? user = userController.userModel.value;

                if (user == null) {
                  return  Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  );
                }

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                  child: SingleChildScrollView(
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
                                backgroundColor: Colors.grey.shade300,
                                child: user.profile.isNotEmpty && File(user.profile).existsSync()
                                    ? ClipOval(
                                  child: Image.file(
                                    File(user.profile),
                                    width: 10.h,
                                    height: 10.h,
                                    fit: BoxFit.cover,
                                  ),
                                )
                                    : const Icon(
                                  Icons.person,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                              ),
                              verticalSpace(.6.h),
                              Text(
                                user.userName.isEmpty ? 'User' : user.userName,
                                style: AppTextStyles.semiBoldTextStyle.copyWith(
                                  color: AppColors.textColor,
                                  fontSize: 18.sp,
                                ),
                              ),
                              verticalSpace(1.h),
                              CustomButton(
                                height: 4.h,
                                width: 24.w,
                                title: "edit".tr,
                                border: Border.all(color: Colors.transparent),
                                onTap: () => showEditProfileDialog(context, userController, user),
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
                );
              }),
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