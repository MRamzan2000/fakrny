// widgets/dose_times_grid.dart
import 'package:fakrny/controllers/medicine_controller.dart';
import 'package:fakrny/utils/app_text_styles.dart';
import 'package:fakrny/views/reused_widgets/vertical_space.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DoseTimesGrid extends StatelessWidget {
  final MedicineController controller;
  const DoseTimesGrid({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final count = int.parse(controller.frequency.value.split(' ')[0]);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 3.w,
            runSpacing: 1.5.h,
            children: List.generate(count, (i) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${i + 1}dose_time".tr, style: AppTextStyles.smallTextStyle),
                verticalSpace(0.5.h),
                GestureDetector(
                  onTap: () async {
                    final picked = await showTimePicker(
                      context: context,
                      initialTime: controller.doseTimes[i].value.isEmpty
                          ? TimeOfDay.now()
                          : _parseTime(controller.doseTimes[i].value),
                    );
                    if (picked != null) {
                      final formatted = "${picked.hour.toString().padLeft(2,'0')}:${picked.minute.toString().padLeft(2,'0')} ${picked.period.name.toUpperCase()}";
                      controller.doseTimes[i].value = formatted;
                    }
                  },
                  child: Container(
                    width: 28.w,
                    padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.4.h),
                    decoration: BoxDecoration(border: Border.all(color: const Color(0xffE0E0E0)), borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      controller.doseTimes[i].value.isEmpty ? "--:-- --" : controller.doseTimes[i].value,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.regularTextStyle.copyWith(fontSize: 16.sp),
                    ),
                  ),
                ),
              ],
            )),
          ),
        ],
      );
    });
  }

  TimeOfDay _parseTime(String time) {
    final parts = time.split(' ');
    final hm = parts[0].split(':');
    int h = int.parse(hm[0]);
    final m = int.parse(hm[1]);
    if (parts.length > 1 && parts[1] == 'PM' && h != 12) h += 12;
    if (parts.length > 1 && parts[1] == 'AM' && h == 12) h = 0;
    return TimeOfDay(hour: h, minute: m);
  }
}