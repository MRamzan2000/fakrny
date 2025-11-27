import 'package:fakrny/views/screens/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
        title: const Text("Profile", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: const Color(0xFFE8FFFB),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      "https://randomuser.me/api/portraits/men/46.jpg", // Replace with actual image if needed
                    ),
                  ),
                  SizedBox(height: 2.h),
                  const Text(
                    "Mohsin",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 1.5.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00D9B8),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text(
                      "Edit",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 4.h),

            _buildMenuItem(icon: Icons.settings_outlined, title: "Settings", onTap: () => Get.to(() => const SettingsScreen())),
            _buildMenuItem(icon: Icons.privacy_tip_outlined, title: "Privacy Policy", onTap: () {}),
            _buildMenuItem(icon: Icons.star_border, title: "Rate Us", onTap: () {}),
            _buildMenuItem(icon: Icons.share_outlined, title: "Share", onTap: () {}),
            _buildMenuItem(icon: Icons.logout, title: "Log out", onTap: () {}, color: Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({required IconData icon, required String title, required VoidCallback onTap, Color? color}) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 4.w),
      leading: Icon(icon, color: color ?? const Color(0xFF00D9B8), size: 26),
      title: Text(title, style: TextStyle(fontSize: 17.sp, color: color ?? Colors.black87)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black54),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      tileColor: const Color(0xFFE8FFFB),
      onTap: onTap,
      minVerticalPadding: 20,
    );
  }
}