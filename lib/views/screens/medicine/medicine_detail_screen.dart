import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fakrny/controllers/medicine_controller.dart';
import 'package:fakrny/models/medicine_model.dart';
import 'package:fakrny/services/firestore_service.dart';
import 'package:fakrny/utils/app_colors.dart';
import 'package:fakrny/utils/app_message.dart';
import 'package:fakrny/utils/app_text_styles.dart';
import 'package:fakrny/views/reused_widgets/elevated_button.dart';
import 'package:fakrny/views/reused_widgets/horizontal_space.dart';
import 'package:fakrny/views/reused_widgets/reused_able_appbar.dart';
import 'package:fakrny/views/reused_widgets/vertical_space.dart';
import 'package:fakrny/views/screens/medicine/add_medicine_screen_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MedicineDetailScreen extends StatelessWidget {
  final String medicineId;

  const MedicineDetailScreen({
    super.key,
    required this.medicineId,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MedicineController>();

    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          final medicine = _findMedicineById(controller, medicineId);
          if (medicine == null) {
            return const Center(child: Text("Medicine not found."));
          }

          final isActive = medicine.isActive;
          final isTodayInCourse = _isTodayInRange(medicine.startDate, medicine.endDate);

          return Column(
            children: [
              Container(
                color: AppColors.appBarColor,
                child: Row(
                  children: [
                    Expanded(child: appBar(title: medicine.name)),
                    Padding(
                      padding: EdgeInsets.only(right: 4.w),
                      child: InkWell(
                        onTap: isActive
                            ? () => Get.to(() => AddMedicineScreenDetails(medicineId: medicineId))
                            : null,
                        child: Text(
                          "Edit".tr,
                          style: AppTextStyles.regularTextStyle.copyWith(
                            color: isActive ? AppColors.primaryColor : Colors.grey,
                            fontSize: 17.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              verticalSpace(.5.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 1.h),
                color: _getStatusColor(medicine.status),
                child: Center(
                  child: Text(
                    _getStatusText(medicine.status),
                    style: AppTextStyles.semiBoldTextStyle.copyWith(fontSize: 16.sp, color: Colors.white),
                  ),
                ),
              ),

              verticalSpace(1.h),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: medicine.imagePath.startsWith('http') || (medicine.imagePath.isNotEmpty && File(medicine.imagePath).existsSync())
                            ? Image.file(File(medicine.imagePath), height: 35.h, fit: BoxFit.contain)
                            : Image.asset(medicine.imagePath, height: 35.h, fit: BoxFit.contain),
                      ),
                      verticalSpace(1.h),
                      _buildInfoRow(
                        icon: "assets/icons/name_medi.svg",
                        label: "medicine_name".tr,
                        value: medicine.name,
                      ),
                      verticalSpace(1.h),
                      const Divider(),
                      verticalSpace(.5.h),

                      // Dosage
                      _buildInfoRow(
                        icon: "assets/icons/dosage_medi.svg",
                        label: "medicine_dosage_label".tr,
                        value: medicine.dosage,
                      ),
                      verticalSpace(1.h),
                      const Divider(),
                      verticalSpace(.5.h),

                      // Dose & Stock
                      Row(
                        children: [
                          Expanded(
                            child: _buildSmallInfo(
                              icon: "assets/icons/dose_medi.svg",
                              label: "medicine_dose".tr,
                              value: medicine.dose,
                            ),
                          ),
                          horizontalSpace(4.w),
                          Expanded(
                            child: _buildSmallInfo(
                              icon: "assets/icons/stock_medi.svg",
                              label: "medicine_stock".tr,
                              value: "${medicine.stock} left",
                              isWarning: medicine.stock <= 5,
                            ),
                          ),
                        ],
                      ),
                      verticalSpace(1.h),
                      const Divider(),
                      verticalSpace(.5.h),

                      // Dates
                      Text("dosage_frequency_time".tr, style: AppTextStyles.semiBoldTextStyle.copyWith(fontSize: 17.sp)),
                      verticalSpace(1.h),
                      Row(
                        children: [
                          Expanded(child: _buildDateBox(label: "start_date".tr, date: _formatDate(medicine.startDate))),
                          horizontalSpace(3.w),
                          Expanded(child: _buildDateBox(label: "end_date".tr, date: _formatDate(medicine.endDate))),
                        ],
                      ),
                      verticalSpace(1.h),
                      const Divider(),
                      verticalSpace(.5.h),

                      // Frequency
                      Text("dosage_frequency".tr, style: AppTextStyles.semiBoldTextStyle.copyWith(fontSize: 17.sp)),
                      verticalSpace(0.8.h),
                      Text(medicine.frequency, style: AppTextStyles.regularTextStyle.copyWith(fontSize: 16.sp)),
                      verticalSpace(1.h),

                      // Dose Times
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          medicine.doseTimes.length.clamp(0, 3),
                              (i) => _buildTimeBox("${i + 1}_dose_time".tr, medicine.doseTimes[i]),
                        ),
                      ),
                      verticalSpace(1.h),
                      const Divider(),
                      verticalSpace(.5.h),

                      // Instructions
                      Text("medicine_instructions".tr, style: AppTextStyles.semiBoldTextStyle.copyWith(fontSize: 17.sp)),
                      verticalSpace(1.h),
                      _buildInstructionRow("how_to_take".tr, medicine.howToTake),
                      verticalSpace(1.h),
                      const Divider(),
                      verticalSpace(.5.h),
                      _buildInstructionRow("special_instructions".tr, medicine.instructions),
                      verticalSpace(1.h),
                      const Divider(),
                      verticalSpace(.5.h),

                      // Voice Alert
                      Text("voice_sound_alert".tr, style: AppTextStyles.semiBoldTextStyle.copyWith(fontSize: 17.sp)),
                      verticalSpace(1.h),
                      Text(
                        medicine.voiceAlert && isActive ? "voice_alert_enabled".tr : "voice_alert_disabled".tr,
                        style: AppTextStyles.smallTextStyle,
                      ),
                      verticalSpace(.3.h),
                      Text(
                        medicine.voiceAlert && isActive ? "Custom voice message will play" : "no_alert_message".tr,
                        style: AppTextStyles.regularTextStyle.copyWith(fontSize: 16.sp),
                      ),
                      verticalSpace(1.h),
                      const Divider(),
                      verticalSpace(.5.h),

                      // Today's Doses (Only if active and today in course)
                      if (isActive && isTodayInCourse) ...[
                        Text("today_doses".tr, style: AppTextStyles.semiBoldTextStyle.copyWith(fontSize: 18.sp,color: AppColors.primaryColor)),
                        verticalSpace(2.h),
                        ..._buildTodayDoses(medicine, controller),
                        verticalSpace(4.h),
                      ],

                      // Adherence Rate
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            Text("adherence_rate".tr, style: AppTextStyles.semiBoldTextStyle.copyWith(fontSize: 17.sp,color: AppColors.textColor)),
                            verticalSpace(1.h),
                            Text(
                              "${medicine.adherencePercentage.toStringAsFixed(1)}%",
                              style: TextStyle(fontSize: 34.sp, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
                            ),
                            Text(
                              "${medicine.takenDoses} taken • ${medicine.missedDoses} missed",
                              style: AppTextStyles.smallTextStyle,
                            ),
                          ],
                        ),
                      ),

                      verticalSpace(5.h),

                      // Stop Button
                      if (isActive)
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: CustomButton(
                            height: 5.5.h,
                            title: "stop_medicine".tr,
                            onTap: () async {
                              showStopMedicineDialog(context,controller);

                            },
                          ),
                        ),

                      verticalSpace(3.h),

                      // Course Ended Info
                      if (!isActive)
                        Container(
                          padding: EdgeInsets.all(4.w),
                          decoration: BoxDecoration(
                            color: AppColors.lightGrey,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "course_ended".tr,
                                style: AppTextStyles.boldTextStyle.copyWith(fontSize: 17.sp),
                              ),
                              verticalSpace(1.h),
                              Text(
                                "all_doses_alerts_inactive".tr,
                                style: AppTextStyles.smallTextStyle,
                              ),
                            ],
                          ),
                        ),

                      verticalSpace(10.h),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
  // Custom Stop Medicine Dialog with Reason
  Future<String?> showStopMedicineDialog(BuildContext context,MedicineController controller) async {
    final TextEditingController reasonController = TextEditingController();

    return await showDialog<String>(
      context: context,
      barrierDismissible: false, // User must tap button to close
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.sp),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "stop_medicine".tr,
                  style: AppTextStyles.semiBoldTextStyle.copyWith(
                    fontSize: 17.sp,
                    color: AppColors.textColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                verticalSpace(1.3.h),
                Text(
                  "stop_medicine_confirm_reason".tr,
                  style: AppTextStyles.regularTextStyle.copyWith(
                    fontSize: 15.4.sp,
                    color: AppColors.textColor,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                verticalSpace(1.5.h),
                TextFormField(
                  controller: reasonController,
                  decoration: InputDecoration(
                    hintText: "type_here".tr,
                    hintStyle: AppTextStyles.smallTextStyle.copyWith(
                      fontSize: 14.sp,
                      color: Colors.grey,
                    ),
                    filled: true,
                    isCollapsed: true,
                    fillColor: AppColors.appBarColor,
                    contentPadding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.sp),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  maxLines: 3,
                ),
                verticalSpace(2.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          horizontal: 3.5.h,
                          isGradient: true,
                          gradient: LinearGradient(colors: [
                            Colors.transparent,
                            Colors.transparent,
                          ]),
                          height: 5.h,
                          title: "cancel".tr,
                          border: Border.all(color: Colors.transparent),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10.px),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          textColor: Colors.white,
                        ),
                      ),
                      horizontalSpace(3.w),
                      Expanded(
                        child: CustomButton(
                          horizontal: 3.5.h,
                          isGradient: true,
                          gradient: LinearGradient(colors: [Color(0xffFF5F57), Color(0xffFF5F57)]),
                          border: Border.all(color: Colors.transparent),
                          height: 5.h,
                          title: "Stopped".tr,
                          style: AppTextStyles.buttonTextStyle.copyWith(color: Colors.white),

                          borderRadius: BorderRadius.circular(10.px),
                          onTap: () async {
                            final reason = reasonController.text.trim();
                            if (reason.isEmpty) {
                              await controller.stopMedicine(medicineId);
                              AppMessage.success(reason);
                              Get.back();
                            }
                          },
                          textColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                verticalSpace(1.h),
              ],
            ),
          ),
        );
      },
    );
  }
  // ALL REUSABLE WIDGETS (tera original)
  MedicineModel? _findMedicineById(MedicineController controller, String id) {
    return controller.activeMedicines.firstWhereOrNull((m) => m.id == id) ??
        controller.historyMedicines.firstWhereOrNull((m) => m.id == id);
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'ongoing': return Colors.green;
      case 'completed': return Colors.blue;
      case 'completed_with_missed': return Colors.orange;
      case 'completed_early': return Colors.purple;
      case 'stopped': return Colors.redAccent;
      default: return Colors.grey;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'ongoing': return "Active".tr;
      case 'completed': return "Completed".tr;
      case 'completed_with_missed': return "Completed with Missed".tr;
      case 'completed_early': return "Completed Early".tr;
      case 'stopped': return "Stopped".tr;
      default: return status.tr;
    }
  }

  Widget _buildInfoRow({required String icon, required String label, required String value}) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: AppTextStyles.smallTextStyle.copyWith(fontSize: 16.5.sp)),
      verticalSpace(.6.h),
      Row(
        children: [
          SvgPicture.asset(icon, height: 3.3.h),
          horizontalSpace(2.w),
          Text(value, style: AppTextStyles.regularTextStyle.copyWith(fontSize: 17.sp)),
        ],
      ),
    ],
  );

  Widget _buildSmallInfo({required String icon, required String label, required String value, bool isWarning = false}) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: AppTextStyles.smallTextStyle.copyWith(fontSize: 16.5.sp)),
      verticalSpace(.6.h),
      Row(
        children: [
          SvgPicture.asset(icon, height: 3.h),
          horizontalSpace(2.w),
          Text(value, style: AppTextStyles.regularTextStyle.copyWith(fontSize: 15.5.sp, color: isWarning ? Colors.red : null)),
        ],
      ),
    ],
  );

  Widget _buildDateBox({required String label, required String date}) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: AppTextStyles.smallTextStyle.copyWith(fontSize: 16.5.sp)),
      verticalSpace(0.8.h),
      Row(
        children: [
          Text(date, style: AppTextStyles.regularTextStyle.copyWith(fontSize: 15.5.sp)),
          horizontalSpace(3.w),
          SvgPicture.asset("assets/icons/date_medi.svg", height: 3.h),
        ],
      ),
    ],
  );

  Widget _buildTimeBox(String label, String time) => Expanded(
    child: Column(
      children: [
        Text(label, style: AppTextStyles.smallTextStyle),
        verticalSpace(0.8.h),
        Text(time.isNotEmpty ? time : "N/A", style: AppTextStyles.regularTextStyle.copyWith(fontSize: 16.sp)),
      ],
    ),
  );

  Widget _buildInstructionRow(String title, String value) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: AppTextStyles.smallTextStyle),
      verticalSpace(0.8.h),
      Text(value.isNotEmpty ? value : "no_instructions".tr, style: AppTextStyles.regularTextStyle.copyWith(fontSize: 16.sp)),
    ],
  );

  List<Widget> _buildTodayDoses(MedicineModel medicine, MedicineController controller) {
    final now = DateTime.now();
    final todayStr = DateFormat('yyyy-MM-dd').format(now);
    return [
      StreamBuilder<QuerySnapshot>(
        stream: FirestoreService()
            .getDosesStreamForDate(medicine.id, todayStr),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error loading doses");
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Text("No doses scheduled for today");
          }

          final doseDocs = snapshot.data!.docs;

          // Sort by time
          doseDocs.sort((a, b) {
            final timeA = a['time'] as String;
            final timeB = b['time'] as String;
            return timeA.compareTo(timeB);
          });

          return Column(
            children: doseDocs.map((doseDoc) {
              final data = doseDoc.data() as Map<String, dynamic>;
              final doseId = doseDoc.id;
              final timeStr = data['time'] as String;
              final status = data['status'] as String; // pending, taken, missed, cancelled
              final time = _parseTime(timeStr);
              final doseTime = DateTime(now.year, now.month, now.day, time.hour, time.minute);

              final isPast = doseTime.isBefore(now.subtract(const Duration(minutes: 30)));
              final isTaken = status == 'taken';
              final isMissed = status == 'missed' || (status == 'pending' && isPast);

              return Container(
                key: ValueKey(doseId),
                margin: EdgeInsets.only(bottom: 2.h),
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2))],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 26,
                      backgroundColor: isTaken
                          ? Colors.green.withOpacity(0.2)
                          : isMissed
                          ? Colors.red.withOpacity(0.2)
                          : AppColors.primaryColor.withOpacity(0.1),
                      child: Text(
                        "${doseDocs.indexOf(doseDoc) + 1}",
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: isTaken
                              ? Colors.green
                              : isMissed
                              ? Colors.red
                              : AppColors.primaryColor,
                        ),
                      ),
                    ),
                    horizontalSpace(4.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "dose".trParams({'n': (doseDocs.indexOf(doseDoc) + 1).toString()}),
                            style: AppTextStyles.semiBoldTextStyle.copyWith(fontSize: 17.sp),
                          ),
                          Text(
                            timeStr,
                            style: AppTextStyles.regularTextStyle.copyWith(fontSize: 18.sp),
                          ),
                        ],
                      ),
                    ),
                    // Status Chip
                    if (isTaken)
                      Chip(
                          label: Text("taken".tr, style: TextStyle(color: Colors.white)),
                          backgroundColor: Colors.green,
                      )
                    else if (isMissed)
                      Chip(
                        label: Text("missed".tr, style: TextStyle(color: Colors.white)),
                        backgroundColor: Colors.red,
                      )
                    else // Pending + current time
                      Row(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                            onPressed: () async {
                              await controller.markDoseAsTaken(medicine.id, doseId);
                            },
                            child: Text("taken".tr, style: TextStyle(color: Colors.white)),
                          ),
                          horizontalSpace(2.w),
                          OutlinedButton(
                            onPressed: () {
                              // Optional: manual skip = mark missed
                              Get.dialog(
                                AlertDialog(
                                  title: Text("skip_dose".tr),
                                  content: Text("skip_dose_confirm".tr),
                                  actions: [
                                    TextButton(onPressed: () => Get.back(), child: Text("cancel".tr)),
                                    TextButton(
                                      onPressed: () async {
                                        Get.back();
                                        await controller.markDoseAsMissed(medicine.id, doseId);
                                        AppMessage.error("dose_skipped".tr);
                                      },
                                      child: Text("skip".tr, style: TextStyle(color: Colors.red)),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Text("skip".tr),
                          ),
                        ],
                      ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    ];
  }
  TimeOfDay _parseTime(String timeStr) {
    final parts = timeStr.split(' ');
    final hm = parts[0].split(':');
    int h = int.parse(hm[0]);
    final m = int.parse(hm[1]);
    if (parts[1] == 'PM' && h != 12) h += 12;
    if (parts[1] == 'AM' && h == 12) h = 0;
    return TimeOfDay(hour: h, minute: m);
  }

  bool _isTodayInRange(DateTime start, DateTime end) {
    final today = DateTime.now();
    return !today.isBefore(start) && !today.isAfter(end);
  }
}