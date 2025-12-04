import 'package:fakrny/utils/app_colors.dart';
import 'package:fakrny/utils/app_text_styles.dart';
import 'package:fakrny/views/reused_widgets/horizontal_space.dart';
import 'package:fakrny/views/reused_widgets/vertical_space.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:table_calendar/table_calendar.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  DateTime selectedDay = DateTime(2025, 7, 23);
  DateTime focusedDay = DateTime(2025, 7, 23);

  final takenDays = {1,2,3,4,5,6,7,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,27};
  final missedDays = {8, 26, 28, 30, 31};

  bool _isGreen(DateTime day) => takenDays.contains(day.day);
  bool _isRed(DateTime day) => missedDays.contains(day.day);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(2.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "statistics".tr,
                    style: AppTextStyles.boldTextStyle.copyWith(
                      color: AppColors.textColor,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              verticalSpace(2.h),

              // Month Navigation
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => setState(() => focusedDay = DateTime(focusedDay.year, focusedDay.month - 1, 1)),
                    child: const Icon(Icons.chevron_left),
                  ),
                  Text(
                    "july_2025".tr, // "July 2025"
                    style: AppTextStyles.smallTextStyle.copyWith(fontSize: 17.sp),
                  ),
                  InkWell(
                    onTap: () => setState(() => focusedDay = DateTime(focusedDay.year, focusedDay.month + 1, 1)),
                    child: const Icon(Icons.chevron_right),
                  ),
                ],
              ),

              verticalSpace(2.h),

              // Calendar
              TableCalendar(
                rowHeight: 5.3.h,
                firstDay: DateTime.utc(2020),
                lastDay: DateTime.utc(2030),
                focusedDay: focusedDay,
                selectedDayPredicate: (day) => isSameDay(day, selectedDay),
                headerVisible: false,
                calendarFormat: CalendarFormat.month,
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: AppTextStyles.smallTextStyle.copyWith(fontSize: 17.sp),
                  weekendStyle: AppTextStyles.smallTextStyle.copyWith(fontSize: 16.sp),
                ),
                onDaySelected: (selected, focused) => setState(() {
                  selectedDay = selected;
                  focusedDay = focused;
                }),
                calendarStyle: const CalendarStyle(
                  cellMargin: EdgeInsets.zero,
                  cellPadding: EdgeInsets.zero,
                  cellAlignment: Alignment.center,
                  defaultDecoration: BoxDecoration(shape: BoxShape.circle, color: Colors.transparent),
                  todayDecoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black),
                  selectedDecoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black),
                ),
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, day, _) {
                    if (_isGreen(day)) return _circle(day.day, Colors.greenAccent);
                    if (_isRed(day)) return _circle(day.day, Colors.redAccent);
                    return Center(child: Text(day.day.toString(), style: AppTextStyles.smallTextStyle.copyWith(fontSize: 16.sp)));
                  },
                  selectedBuilder: (context, day, _) => _circle(day.day, Colors.black, textColor: Colors.white),
                  todayBuilder: (context, day, _) => _circle(day.day, Colors.black, textColor: Colors.white),
                ),
              ),

              verticalSpace(2.h),

              // Streak & Missed
              Row(
                children: [
                  _infoBox("current_streak".tr, "7_days".tr),
                  horizontalSpace(2.h),
                  _infoBox("missed_doses".tr, "5", isRed: true),
                ],
              ),

              verticalSpace(1.5.h),

              // Selected Date
              Text(
                "selected_date".trArgs([selectedDay.day.toString(), "july_25".tr]),
                style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600),
              ),

              verticalSpace(1.5.h),

              // Medicine List
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    _medicineTile("Risek".tr, "dose_3_times".tr, "taken_taken_missed".tr, "assets/images/risek.png"),
                    const Divider(),
                    _medicineTile("Captopril".tr, "dose_2_times".tr, "taken_taken".tr, "assets/images/captopril.png"),
                    const Divider(),
                    _medicineTile("I-DROP MGD".tr, "dose_3_times".tr, "taken_taken_missed".tr, "assets/images/sudafed.png"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _circle(int day, Color color, {Color textColor = Colors.white}) => Container(
    height: 3.h,
    width: 9.w,
    decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    alignment: Alignment.center,
    child: Text(day.toString(), style: AppTextStyles.smallTextStyle.copyWith(color: textColor, fontSize: 16.sp)),
  );

  Widget _infoBox(String title, String value, {bool isRed = false}) => Expanded(
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
      decoration: BoxDecoration(color: AppColors.appBarColor, borderRadius: BorderRadius.circular(14)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 14, color: Colors.black54)),
          verticalSpace(.5.h),
          Text(value, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: isRed ? Colors.red : Colors.green)),
        ],
      ),
    ),
  );

  Widget _medicineTile(String name, String dose, String status, String assetPath) => ListTile(
    contentPadding: EdgeInsets.zero,
    leading: ClipRRect(
      borderRadius: BorderRadius.circular(12.px),
      child: Container(
        height: 10.h,
        color: const Color(0xffF6F6F6),
        child: Image.asset(assetPath, fit: BoxFit.contain),
      ),
    ),
    title: Text(name, style: AppTextStyles.semiBoldTextStyle.copyWith(fontSize: 18.sp, color: const Color(0xff353535))),
    subtitle: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpace(.5.h),
        Text(dose, style: AppTextStyles.smallTextStyle.copyWith(fontSize: 16.sp, color: const Color(0xff353535))),
        Text(status, style: const TextStyle(fontSize: 14, color: Colors.red)),
      ],
    ),
  );
}