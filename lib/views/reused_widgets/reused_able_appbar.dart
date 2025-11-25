import 'package:fakrny/utils/app_colors.dart';
import 'package:fakrny/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Widget appBar({
  required String title
}){
  return  Padding(
    padding:EdgeInsets.only(right: 3.w),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      height: 8.h,
      width: double.infinity,
      color: AppColors.appBarColor,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(onTap: (){
            Get.back();
          },
              child: Icon(Icons.arrow_back_ios_new_rounded,size: 3.h,)),
          Expanded(
            child: SizedBox(

            ),
          ),
          Text(title,style: AppTextStyles.boldTextStyle.copyWith(
              color: AppColors.textColor,
              fontSize: 19.sp,
              fontWeight: FontWeight.w500
          ),),
          Expanded(
            child: SizedBox(
              width: 6.w,

            ),
          )
        ],),

    ),
  );
}