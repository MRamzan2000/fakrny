import 'dart:io';
import 'package:fakrny/controllers/medicine_controller.dart';
import 'package:fakrny/models/medicine_model.dart';
import 'package:fakrny/utils/app_colors.dart';
import 'package:fakrny/utils/app_text_styles.dart';
import 'package:fakrny/views/reused_widgets/horizontal_space.dart';
import 'package:fakrny/views/reused_widgets/vertical_space.dart';
import 'package:fakrny/views/screens/medicine/medicine_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyMedsScreen extends StatelessWidget {
  MyMedsScreen({super.key});

  final controller = Get.find<MedicineController>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Text(
            "my_medication".tr,
            style: AppTextStyles.semiBoldTextStyle.copyWith(
              fontSize: 21.sp,
              color: AppColors.textColor,
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Column(
              children: [
                verticalSpace(2.h),

                // ===== TABS WITH BADGE COUNT =====
                Obx(() => Container(
                  height: 6.5.h,
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 20,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: TabBar(
                    dividerColor: Colors.transparent,
                    indicator: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: AppColors.grey,
                    labelStyle: AppTextStyles.semiBoldTextStyle.copyWith(fontSize: 16.sp),
                    tabs: [
                      _buildTab("active".tr, controller.activeMedicines.length),
                      _buildTab("history".tr, controller.historyMedicines.length),
                    ],
                  ),
                )),

                verticalSpace(3.h),
                Expanded(
                  child: TabBarView(
                    children: [
                      _buildMedicineList(controller.activeMedicines, isActive: true),
                      _buildMedicineList(controller.historyMedicines, isActive: false),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTab(String title, int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title),            // <-- Correct bracket here
        horizontalSpace(2.w),

        if (count > 0)
          Container(
            padding: EdgeInsets.all(1.8.w),
            decoration: const BoxDecoration(
              color: Color(0xff0B2455),
              shape: BoxShape.circle,
            ),
            child: Text(
              count.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildMedicineList(List<MedicineModel> medicines, {required bool isActive}) {
    if (medicines.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isActive ? Icons.medication_outlined : Icons.history,
              size: 60,
              color: Colors.grey[400],
            ),
            verticalSpace(2.h),
            Text(
              isActive ? "no_active_medicines".tr : "no_history_yet".tr,
              style: AppTextStyles.regularTextStyle.copyWith(fontSize: 18.sp, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: medicines.length,
      separatorBuilder: (_, __) => verticalSpace(2.h),
      itemBuilder: (context, index) {
        final medicine = medicines[index];
        return GestureDetector(
          onTap: () => Get.to(() => MedicineDetailScreen(medicineId: medicine.id,)),
          child: _buildMedicineCard(medicine, isActive: isActive),
        );
      },
    );
  }

  Widget _buildMedicineCard(MedicineModel medicine, {required bool isActive}) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.sp),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          // Medicine Image
          ClipRRect(
            borderRadius: BorderRadius.circular(14.sp),
            child: Container(
              height: 11.h,
              width: 15.h,
              color: const Color(0xffF8F8F8),
              child: _safeImage(medicine.imagePath),
            ),
          ),

          horizontalSpace(4.w),

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name
                Text(
                  medicine.name,
                  style: AppTextStyles.semiBoldTextStyle.copyWith(fontSize: 18.5.sp,color: AppColors.textColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                verticalSpace(0.5.h),

                // Frequency
                Text(
                  medicine.frequency,
                  style: AppTextStyles.smallTextStyle.copyWith(fontSize: 15.5.sp, color: AppColors.textColor.withOpacity(0.8)),
                ),
                verticalSpace(0.8.h),

                // Dates
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 14.sp, color: Colors.grey[600]),
                    horizontalSpace(1.w),
                    Text(
                      "${_fmt(medicine.startDate)} → ${_fmt(medicine.endDate)}",
                      style: AppTextStyles.smallTextStyle.copyWith(fontSize: 14.sp),
                    ),
                  ],
                ),
                verticalSpace(1.h),

                // Status + Adherence Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Status Badge
                    _statusBadge(medicine.status),

                    // Adherence % (only for active)
                    if (isActive && medicine.totalDoses > 0)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                        decoration: BoxDecoration(
                          color: medicine.adherencePercentage >= 80 ? Colors.green.shade50 : Colors.orange.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: medicine.adherencePercentage >= 80 ? Colors.green : Colors.orange,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          "${medicine.adherencePercentage.toStringAsFixed(0)}%",
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: medicine.adherencePercentage >= 80 ? Colors.green.shade700 : Colors.orange.shade700,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),

          // Arrow
          Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey[400]),
        ],
      ),
    );
  }

  Widget _statusBadge(String status) {
    Color bgColor;
    Color textColor;
    String displayText;

    switch (status) {
      case 'ongoing':
        bgColor = Colors.blue.shade100;
        textColor = Colors.blue.shade700;
        displayText = "active".tr;
        break;
      case 'completed':
        bgColor = Colors.green.shade100;
        textColor = Colors.green.shade700;
        displayText = "completed".tr;
        break;
      case 'completed_with_missed':
        bgColor = Colors.orange.shade100;
        textColor = Colors.orange.shade700;
        displayText = "completed_with_missed".tr;
        break;
      case 'completed_early':
        bgColor = Colors.purple.shade100;
        textColor = Colors.purple.shade700;
        displayText = "completed_early".tr;
        break;
      case 'stopped':
        bgColor = Colors.red.shade100;
        textColor = Colors.red.shade700;
        displayText = "stopped".tr;
        break;
      default:
        bgColor = Colors.grey.shade200;
        textColor = Colors.grey.shade700;
        displayText = status;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        displayText,
        style: AppTextStyles.smallTextStyle.copyWith(
          fontSize: 14.sp,
          color: textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _safeImage(String path) {
    if (path.isEmpty) {
      return Image.asset("assets/images/default_med.png", fit: BoxFit.cover);
    }
    if (File(path).existsSync()) {
      return Image.file(File(path), fit: BoxFit.cover);
    }
    return Image.asset("assets/images/default_med.png", fit: BoxFit.cover);
  }

  String _fmt(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }
}