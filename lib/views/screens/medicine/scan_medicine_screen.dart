import 'package:camera/camera.dart';
import 'package:fakrny/utils/app_colors.dart';
import 'package:fakrny/utils/app_text_styles.dart';
import 'package:fakrny/views/reused_widgets/reused_able_appbar.dart';
import 'package:fakrny/views/reused_widgets/vertical_space.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'doctor_prescription_screen.dart' show DoctorPrescriptionScreen;

class ScanMedicine extends StatefulWidget {
  const ScanMedicine({super.key});

  @override
  State<ScanMedicine> createState() => _ScanMedicineState();
}

class _ScanMedicineState extends State<ScanMedicine> {
  CameraController? controller;
  bool isCameraReady = false;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async {
    final cameras = await availableCameras();
    controller = CameraController(
      cameras.first,
      ResolutionPreset.high,
      enableAudio: false,
    );

    await controller!.initialize();
    if (mounted) {
      setState(() => isCameraReady = true);
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            appBar(title: "scanning_title".tr),

            verticalSpace(2.h),
            Text(
              "doctor_prescription".tr,
              style: AppTextStyles.semiBoldTextStyle.copyWith(
                color: AppColors.textColor,
                fontSize: 18.sp,
              ),
            ),

            verticalSpace(2.h),

            // Camera Preview Box
            Expanded(
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green, width: 3),
                    borderRadius: BorderRadius.circular(12.px),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.px),
                    child: isCameraReady
                        ? CameraPreview(controller!)
                        : const Center(
                      child: CircularProgressIndicator(color: Colors.green),
                    ),
                  ),
                ),
              ),
            ),

            verticalSpace(2.h),
            Padding(
              padding: EdgeInsets.only(bottom: 2.h),
              child: GestureDetector(
                onTap: () async {
                  Get.to(() => DoctorPrescriptionScreen());
                  if (!controller!.value.isInitialized) return;
                  await controller!.takePicture();
                },
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: const BoxDecoration(
                    color: Colors.greenAccent,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.camera_alt,
                    size: 3.5.h,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}