import 'package:fakrny/utils/app_colors.dart';
import 'package:fakrny/utils/app_text_styles.dart';
import 'package:fakrny/views/reused_widgets/elevated_button.dart';
import 'package:fakrny/views/reused_widgets/horizontal_space.dart';
import 'package:fakrny/views/reused_widgets/reused_able_appbar.dart';
import 'package:fakrny/views/reused_widgets/vertical_space.dart';
import 'package:fakrny/views/screens/medicine/add_medicine_screen_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DoctorPrescriptionScreen extends StatelessWidget {
  DoctorPrescriptionScreen({super.key});

  final RxList<Map<String, dynamic>> medicines = <Map<String, dynamic>>[
    {
      "image":
      "assets/images/risek.png",
      "name": "Risek",
      "mg": "20mg"
    },
    {
      "image":
      "assets/images/captopril.png",
      "name": "Captopril",
      "mg": "20mg"
    },
    {
      "image":
      "assets/images/sudafed.png",
      "name": "Sudafed Blocked Nose",
      "mg": "20mg"
    },
  ].obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            appBar(title: "Doctor Prescription"),
            verticalSpace(4.h),



            /// LIST
            Expanded(
              child: Obx(
                    () => ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  itemCount: medicines.length,
                  separatorBuilder: (c, i) => SizedBox(height: 2.h),
                  itemBuilder: (context, index) {
                    final item = medicines[index];
                    return Row(children: [
                     Expanded(child:  GestureDetector(onTap: (){
                       Get.to(()=>AddMedicineScreenDetails());
                     },child: Container(
                       padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.3.h),
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(18),
                         border:
                         Border.all(color: AppColors.grey, width: 1),
                         color: Colors.white,
                       ),
                       child: Row(
                         children: [
                           /// IMAGE
                           ClipRRect(
                             borderRadius: BorderRadius.circular(12.px),
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
                                   style: AppTextStyles.semiBoldTextStyle
                                       .copyWith(fontSize: 17.sp,color: AppColors.textColor),
                                 ),
                                 verticalSpace( 0.5.h),
                                 Text(
                                   item["mg"],
                                   style: AppTextStyles.smallTextStyle.copyWith(
                                       fontSize: 15.sp,
                                       color: Colors.black54),
                                 ),
                               ],
                             ),
                           ),
                         ],
                       ),
                     ),),),
                      horizontalSpace(2.w),
                      GestureDetector(
                        onTap: () => medicines.removeAt(index),
                        child: Icon(
                          Icons.close_rounded,
                          color: Colors.red,
                          size: 24.sp,
                        ),
                      ),
                    ],);
                  },
                ),
              ),
            ),

            verticalSpace(2.h),

            /// NEXT BUTTON
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: CustomButton(
                height: 5.5.h,
                title: "Next",
                onTap: () {

                },
              ),
            ),
            verticalSpace(7.h),

          ],
        ),
      ),
    );
  }
}
