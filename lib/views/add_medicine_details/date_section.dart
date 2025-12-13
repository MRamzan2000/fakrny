import 'package:fakrny/controllers/medicine_controller.dart';
import 'package:fakrny/utils/app_colors.dart';
import 'package:fakrny/utils/app_text_styles.dart';
import 'package:fakrny/views/reused_widgets/horizontal_space.dart';
import 'package:fakrny/views/reused_widgets/vertical_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DateSection extends StatelessWidget {
  final MedicineController controller;
  const DateSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("dosage_frequency_time".tr, style: AppTextStyles.smallTextStyle),
        verticalSpace(1.h),
        Row(
          children: [
            Expanded(child: _buildDateField("start_date".tr, controller.startDate, isStartDate: true)),
            horizontalSpace(2.w),
            Expanded(child: _buildDateField("end_date".tr, controller.endDate, isReadOnly: true)),
          ],
        ),
        verticalSpace(1.h),
        Padding(
          padding: EdgeInsets.only(bottom: 1.h),
          child: Text(
            "End date auto-calculated based on stock & frequency",
            style: AppTextStyles.smallTextStyle.copyWith(color: AppColors.primaryColor.withOpacity(0.7), fontSize: 14.sp),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField(String label, Rx<DateTime> date, {bool isStartDate = false, bool isReadOnly = false}) {
    return Obx(() => GestureDetector(
      onTap: isReadOnly ? null : () async {
        final initial = date.value.isBefore(DateTime.now()) ? DateTime.now() : date.value;
        final picked = await showDatePicker(
          context: Get.context!,
          initialDate: initial,
          firstDate: DateTime.now(),
          lastDate: DateTime(2030),
          builder: (context, child) => Theme(
            data: Theme.of(context).copyWith(colorScheme: ColorScheme.light(primary: AppColors.primaryColor)),
            child: child!,
          ),
        );
        if (picked != null) {
          date.value = picked;
          if (isStartDate) controller.autoCalculateEndDate();
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.4.h),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffE0E0E0)),
          borderRadius: BorderRadius.circular(10),
          color: isReadOnly ? AppColors.white.withOpacity(0.6) : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("${date.value.day}-${date.value.month}-${date.value.year}",
                style: AppTextStyles.regularTextStyle.copyWith(fontSize: 16.sp, color: isReadOnly ? Colors.grey[600] : null)),
            if (!isReadOnly) SvgPicture.asset("assets/icons/date_medi.svg", height: 3.h),
          ],
        ),
      ),
    ));
  }
}