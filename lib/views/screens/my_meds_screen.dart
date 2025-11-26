import 'package:fakrny/utils/app_colors.dart';
import 'package:fakrny/utils/app_text_styles.dart';
import 'package:fakrny/views/reused_widgets/horizontal_space.dart';
import 'package:fakrny/views/reused_widgets/vertical_space.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:fakrny/views/reused_widgets/elevated_button.dart';

import 'medicine/medicine_detail_screen.dart';

class MyMedsScreen extends StatelessWidget {
  const MyMedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> medicines = [
      {
        "image": "assets/images/risek.png",
        "name": "Risek",
        "dosage": "3 times per day | 1 Capsule",
        "details": "Started 25 July | 10 Capsules remain"
      },
      {
        "image": "assets/images/captopril.png",
        "name": "Captopril",
        "dosage": "1 time per day | 1 Capsule",
        "details": "Started 25 July | 10 Capsules remain"
      },
      {
        "image": "assets/images/sudafed.png", // Assume asset for I-DROP MGD
        "name": "I-DROP MGD",
        "dosage": "2 times per day | 2 Drops",
        "details": "Started 25 July | 10 Drops remain"
      },
    ];

    return DefaultTabController(length: 2, child:  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: false,
        title:  Text(
          "My medication",
          style: AppTextStyles.semiBoldTextStyle.copyWith(
            fontSize: 18.sp,
            color: AppColors.textColor,
          ),
        ),),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              verticalSpace(3.h),
         Container(
           padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: .5.h),
           height: 6.h,
           width: double.infinity,
           decoration: BoxDecoration(
             color: AppColors.white,
             borderRadius: BorderRadius.circular(25.px),
             boxShadow: [
               BoxShadow(
                 color: Colors.black.withOpacity(0.08),
                 blurRadius: 22,
                 spreadRadius: 1,
                 offset: const Offset(0, 6),
               ),
             ]
           ),
           child:  TabBar(
             labelStyle:AppTextStyles.smallTextStyle.copyWith(
                 color: AppColors.textColor
             ) ,
             tabs: [
             Row(mainAxisAlignment: MainAxisAlignment.center,
               children: [
               Tab(text: 'Active'),
               horizontalSpace(2.w),
               Container(
                 padding: EdgeInsets.all(.5.h),
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(70.px),
                   color: Color(0xff0B2455)
                 ),
                 child: Text("2",style: AppTextStyles.smallTextStyle.copyWith(
                   color: AppColors.white
                 ),),
               )
             ],),
               Row(mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Tab(text: 'Ended '),
                   horizontalSpace(2.w),
                   Container(
                     padding: EdgeInsets.all(.5.h),
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(70.px),
                         color: Color(0xff0B2455)
                     ),
                     child: Text("1",style: AppTextStyles.smallTextStyle.copyWith(
                         color: AppColors.white
                     ),),
                   )
                 ],),
             ],
             indicatorPadding: EdgeInsets.zero,
             indicatorSize:TabBarIndicatorSize.tab ,
             padding: EdgeInsets.zero,
             labelPadding: EdgeInsets.zero,

             dividerColor: Colors.transparent,
             indicator: BoxDecoration(
               color: AppColors.primaryColor,
               borderRadius: BorderRadius.circular(25),
             ),
             labelColor: AppColors.white,
             unselectedLabelColor: AppColors.grey,
           ),
         ),

              verticalSpace(4.h),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: medicines.length,
                  separatorBuilder: (context, index) => SizedBox(height: 2.h),
                  itemBuilder: (context, index) {
                    final item = medicines[index];
                    return GestureDetector(
                      onTap: (){
                        Get.to(() => const MedicineDetailScreen());
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.3.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18.sp),
                          color: AppColors.white,
                        ),
                        child: Row(
                          children: [
                            /// IMAGE
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.sp),
                              child: Container(
                                height: 10.h,
                                color: const Color(0xffF6F6F6),
                                child: Image.asset(
                                  item["image"],
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            horizontalSpace(4.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item["name"],
                                    style: AppTextStyles.semiBoldTextStyle.copyWith(
                                      fontSize: 16.sp,
                                      color: Color(0xff353535),
                                    ),
                                  ),
                                  verticalSpace(0.5.h),
                                  Text(
                                    item["dosage"],
                                    style: AppTextStyles.smallTextStyle.copyWith(
                                      fontSize: 15.sp,
                                      color: Color(0xff353535),
                                    ),
                                  ),
                                  verticalSpace(1.h),
                                  Text(
                                    item["details"],
                                    style: AppTextStyles.smallTextStyle.copyWith(
                                      fontSize: 14.sp,
                                      color: Color(0xff353535),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }


  void showStopMedicineDialog(BuildContext context) {
    final TextEditingController reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.sp),
          ),
          child: Container(
            padding: EdgeInsets.all(5.w),
            constraints: BoxConstraints(
              maxWidth: 90.w,
              maxHeight: 60.h,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(2.h),
                Text(
                  "Stop Medicine",
                  style: AppTextStyles.semiBoldTextStyle.copyWith(
                    fontSize: 20.sp,
                    color: AppColors.primaryColor, // Assuming dark blue-ish for title
                  ),
                ),
                verticalSpace(3.h),
                Text(
                  "Are you sure you want to Stop this medicine?",
                  style: AppTextStyles.regularTextStyle.copyWith(
                    fontSize: 16.sp,
                    color: AppColors.textColor,
                  ),
                ),
                verticalSpace(1.h),
                Text(
                  "if yes write the reason for stopping",
                  style: AppTextStyles.regularTextStyle.copyWith(
                    fontSize: 16.sp,
                    color: AppColors.textColor,
                  ),
                ),
                verticalSpace(3.h),
                TextFormField(
                  controller: reasonController,
                  decoration: InputDecoration(
                    hintText: "Type here",
                    hintStyle: AppTextStyles.smallTextStyle.copyWith(
                      fontSize: 14.sp,
                      color: Colors.grey,
                    ),
                    filled: true,
                    fillColor: Colors.green.shade50, // Light green background
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.sp),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 4.w,
                      vertical: 2.h,
                    ),
                  ),
                  maxLines: 3,
                ),
                verticalSpace(4.h),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        height: 5.h,
                        title: "Continue",
                        onTap: () {
                          // Handle continue logic
                          Navigator.of(context).pop(reasonController.text);
                        },
                        textColor: Colors.white,
                      ),
                    ),
                    horizontalSpace(3.w),
                    Expanded(
                      child: CustomButton(
                        height: 5.h,
                        title: "End",
                        onTap: () {
                          // Handle end logic
                          Navigator.of(context).pop();
                        },
                        textColor: Colors.white,
                      ),
                    ),
                  ],
                ),
                verticalSpace(2.h),
              ],
            ),
          ),
        );
      },
    );
  }
}