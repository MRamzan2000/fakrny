import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fakrny/utils/app_colors.dart';

class AppLoader {
  static bool _isOpen = false;

  static void show({String message = "Please wait..."}) {
    if (_isOpen) return;
    _isOpen = true;

    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.3),
      builder: (_) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Material(color: Colors.transparent,
            child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // App Logo
                  Image.asset(
                    "assets/icons/app_loading.png",
                    height: 60,
                    width: 60,
                  ),
                  const SizedBox(height: 18),
                  // Circular progress indicator with main color
                  CircularProgressIndicator(
                    strokeWidth: 3,
                    color: AppColors.primaryColor,
                  ),
                  const SizedBox(height: 18),
                  // Message text
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  )
                ],
              ),
            ),
          ),)
        );
      },
    );
  }

  static void hide() {
    if (_isOpen) {
      _isOpen = false;
      Navigator.of(Get.context!).pop();
    }
  }
}
