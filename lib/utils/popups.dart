import 'package:fakrny/utils/my_shared_pref.dart';
import 'package:fakrny/views/reused_widgets/elevated_button.dart';
import 'package:fakrny/views/reused_widgets/horizontal_space.dart';
import 'package:fakrny/views/reused_widgets/vertical_space.dart';
import 'package:fakrny/views/screens/auth_screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'app_colors.dart' show AppColors;
import 'app_text_styles.dart' show AppTextStyles;
///Stop Medicine Popup
void showStopMedicineDialog(BuildContext context) {
  final TextEditingController reasonController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.sp),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 2.h),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Stop Medicine",
                style: AppTextStyles.semiBoldTextStyle.copyWith(
                  fontSize: 17.sp,
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w600
                ),
              ),
              verticalSpace(1.3.h),
              Text(
                "Are you sure you want to Stop this medicine?\n if yes write the reason for stopping",
                style: AppTextStyles.regularTextStyle.copyWith(
                  fontSize: 15.4.sp,
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w400
                ),
                textAlign: TextAlign.center,
              ),
              verticalSpace(1.5.h),
              TextFormField(
                controller: reasonController,
                decoration: InputDecoration(
                  hintText: "Type here",
                  hintStyle: AppTextStyles.smallTextStyle.copyWith(
                    fontSize: 14.sp,
                    color: Colors.grey,
                  ),
                  filled: true,
                  isCollapsed: true,
                  fillColor:AppColors.appBarColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.sp),
                    borderSide: BorderSide.none,
                  ),
                ),
                maxLines: 3,
              ),
              verticalSpace(2.h),
              Padding(padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Row(
                  children: [
                    Expanded(child:   CustomButton(
                      horizontal: 3.5.h,
                      height: 5.h,
                      title: "Continue",
                      borderRadius: BorderRadius.circular(10.px),
                      onTap: () {
                        Navigator.of(context).pop(reasonController.text);
                      },
                      textColor: Colors.white,
                    ),),
                    horizontalSpace(3.w),
                    Expanded(child:  CustomButton(
                      horizontal: 3.5.h,
                      isGradient: true,
                      gradient: LinearGradient(colors: [ Color(0xffFF5F57), Color(0xffFF5F57),]),
                      height: 5.h,
                      title: "End",
                      borderRadius: BorderRadius.circular(10.px),
                      onTap: () {
                        Navigator.of(context).pop(reasonController.text);
                      },
                      textColor: Colors.white,
                    ),)
                  ],
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
///Edit Profile
void showEditProfileDialog(BuildContext context) {
  final nameController = TextEditingController(text: "Mohsin");

  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22.sp),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              Text(
                "Edit Profile",
                style: AppTextStyles.semiBoldTextStyle.copyWith(
                  fontSize: 18.sp,
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w600,
                ),
              ),

              verticalSpace(2.h),

              /// Avatar + Camera Button
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 32.sp,
                    backgroundColor: Colors.grey.shade300,
                    child: Icon(Icons.person,
                        size: 40.sp, color: Colors.grey.shade500),
                  ),

                  Container(
                    height: 32.sp,
                    width: 32.sp,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Color(0xff38EF7D), Color(0xff11998E)],
                      ),
                    ),
                    child: Icon(Icons.camera_alt,
                        color: Colors.white, size: 17.sp),
                  )
                ],
              ),

              verticalSpace(3.h),

              Align(
                alignment: Alignment.centerLeft,
                child: Text("Name",
                    style: AppTextStyles.smallTextStyle.copyWith(
                      fontSize: 15.sp,
                      color: AppColors.textColor,
                    )),
              ),
              verticalSpace(.7.h),

              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 4.w, vertical: 1.8.h),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13.sp),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13.sp),
                    borderSide: BorderSide(color: Colors.grey.shade500),
                  ),
                ),
              ),

              verticalSpace(3.h),

              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      title: "Cancel",
                      height: 5.2.h,
                      borderRadius: BorderRadius.circular(30.sp),
                      gradient: const LinearGradient(
                        colors: [Color(0xffD8D8D8), Color(0xffD8D8D8)],
                      ),
                      onTap: () => Navigator.pop(context),
                    ),
                  ),
                  horizontalSpace(3.w),
                  Expanded(
                    child: CustomButton(
                      title: "Save",
                      height: 5.2.h,
                      borderRadius: BorderRadius.circular(30.sp),
                      onTap: () => Navigator.pop(context, nameController.text),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
///Logout Popup
void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22.sp),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              /// Title
              Text(
                "Logout",
                style: AppTextStyles.semiBoldTextStyle.copyWith(
                  fontSize: 18.sp,
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w600,
                ),
              ),

              verticalSpace(2.h),

              /// Description
              Text(
                "Are you sure you want to logout?",
                textAlign: TextAlign.center,
                style: AppTextStyles.regularTextStyle.copyWith(
                  fontSize: 15.sp,
                  color: AppColors.textColor,
                ),
              ),

              verticalSpace(3.h),

              /// Buttons Row
              Row(
                children: [
                  /// Cancel Button
                  Expanded(
                    child: CustomButton(
                      title: "Cancel",
                      height: 5.2.h,
                      borderRadius: BorderRadius.circular(30.sp),
                      border: Border.all(color: Colors.transparent),
                      gradient: const LinearGradient(
                        colors: [Color(0xffD8D8D8), Color(0xffD8D8D8)],
                      ),
                      onTap: () => Navigator.pop(context),
                    ),
                  ),

                  horizontalSpace(3.w),

                  /// Logout Button
                  Expanded(
                    child: CustomButton(
                      title: "Logout",
                      height: 5.2.h,
                      borderRadius: BorderRadius.circular(30.sp),
                      border: Border.all(color: Colors.transparent),
                      isGradient: true,
                      gradient: const LinearGradient(
                        colors: [Color(0xffFF5F57), Color(0xffFF5F57)],
                      ),
                      onTap: () {
                        SharedPrefHelper.logout();
                        Get.offAll(()=>LoginScreen());
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
///Delete Account Popup
void showDeleteAccountDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22.sp),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Delete Account",
                style: AppTextStyles.semiBoldTextStyle.copyWith(
                  fontSize: 18.sp,
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              verticalSpace(2.h),

              Text(
                "Are you sure you want to delete the account?",
                textAlign: TextAlign.center,
                style: AppTextStyles.regularTextStyle.copyWith(
                  fontSize: 15.sp,
                  color: AppColors.textColor,
                ),
              ),

              verticalSpace(3.h),

              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      title: "Continue",
                      height: 5.2.h,
                      borderRadius: BorderRadius.circular(30.sp),
                      onTap: () => Navigator.pop(context, true),
                    ),
                  ),
                  horizontalSpace(3.w),
                  Expanded(
                    child: CustomButton(
                      title: "Delete",
                      height: 5.2.h,
                      borderRadius: BorderRadius.circular(30.sp),
                      isGradient: true,
                      gradient: const LinearGradient(
                        colors: [Color(0xffFF5F57), Color(0xffFF5F57)],
                      ),
                      onTap: () => Navigator.pop(context, false),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}



