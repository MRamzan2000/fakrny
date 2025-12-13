import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:fakrny/utils/app_text_styles.dart';
import 'package:fakrny/views/reused_widgets/reused_able_appbar.dart';
import 'package:fakrny/views/reused_widgets/vertical_space.dart';

class ScheduledMedicinesScreen extends StatelessWidget {
  const ScheduledMedicinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: 100.w,
          height: 100.h,
          child: Column(
            children: [
              appBar(title: "scheduled_medicines".tr),
              verticalSpace(2.h),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('medicines').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    final medicines = snapshot.data?.docs ?? [];
                    int totalNotifications = 0;
                    medicines.forEach((doc) {
                      final data = doc.data() as Map<String, dynamic>;
                      final doseTimes = List<String>.from(data['doseTimes'] ?? []);
                      totalNotifications += doseTimes.length;
                    });
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("total_notifications".tr, style: AppTextStyles.smallTextStyle),
                              Text("$totalNotifications", style: AppTextStyles.regularTextStyle.copyWith(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        verticalSpace(2.h),
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            itemCount: medicines.length,
                            itemBuilder: (context, index) {
                              final doc = medicines[index];
                              final data = doc.data() as Map<String, dynamic>;
                              final name = data['name'] ?? 'Unknown';
                              final doseTimes = List<String>.from(data['doseTimes'] ?? []);
                              final frequency = data['frequency'] ?? '';
                              return Card(
                                margin: EdgeInsets.only(bottom: 1.h),
                                child: Padding(
                                  padding: EdgeInsets.all(2.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(name, style: AppTextStyles.regularTextStyle.copyWith(fontWeight: FontWeight.bold)),
                                      Text(frequency, style: AppTextStyles.smallTextStyle),
                                      verticalSpace(0.5.h),
                                      Text("times".tr, style: AppTextStyles.smallTextStyle),
                                      ...doseTimes.map((time) => Padding(
                                        padding: EdgeInsets.only(top: 0.5.h),
                                        child: Text(time, style: AppTextStyles.hintTextStyle),
                                      )),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}