import 'package:fakrny/views/screens/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FFFE),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE8FFFB),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text("Settings", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
        child: Column(
          children: [
            _settingsTile(
              title: "App Notifications",
              trailing: Switch(value: true, onChanged: (v) {}, activeColor: const Color(0xFF00D9B8)),
            ),
            _settingsTile(title: "Notification Type", onTap: () => Get.to(() => const NotificationTypeScreen())),
            _settingsTile(title: "Change Password", onTap: () {}),
            _settingsTile(title: "Delete Account", onTap: () {}, textColor: Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _settingsTile({required String title, Widget? trailing, VoidCallback? onTap, Color? textColor}) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 4.w),
      title: Text(title, style: TextStyle(fontSize: 17.sp, color: textColor ?? Colors.black87)),
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black54),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      tileColor: const Color(0xFFE8FFFB),
      onTap: onTap,
      minVerticalPadding: 22,
    );
  }
}