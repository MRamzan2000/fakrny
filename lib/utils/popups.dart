import 'package:fakrny/views/reused_widgets/elevated_button.dart';
import 'package:fakrny/views/reused_widgets/horizontal_space.dart';
import 'package:fakrny/views/reused_widgets/vertical_space.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'app_colors.dart' show AppColors;
import 'app_text_styles.dart' show AppTextStyles;

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
