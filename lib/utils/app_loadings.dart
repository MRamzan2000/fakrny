import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_message.dart';

class AppLoader {
  static bool _isShowing = false;

  // Beautiful Full Screen Loader
  static void show({String message = "Please wait..."}) {
    if (_isShowing) return;
    _isShowing = true;

    final context = Get.overlayContext ?? Get.context;
    if (context == null || !context.mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      routeSettings: const RouteSettings(name: 'app_loading'),
      builder: (_) => PopScope(
        canPop: false,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/icons/app_loading.png",
                    height: 70,
                    width: 70,
                    errorBuilder: (_, __, ___) => const Icon(Icons.medication, size: 70, color: Colors.green),
                  ),
                  const SizedBox(height: 20),
                  const CircularProgressIndicator(
                    strokeWidth: 3.5,
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4CAF50)),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    message,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static void hide() {
    if (!_isShowing) return;
    _isShowing = false;
    try {
      final context = Get.overlayContext ?? Get.context;
      if (context != null && context.mounted) {
        Navigator.of(context, rootNavigator: true).pop();
      }
    } catch (_) {}
  }

  static Future<T?> start<T>(
      Future<T> Function() operation, {
        String loadingMessage = "Please wait...",
        String? successMessage,
        String errorMessage = "Something went wrong. Please try again.",
        bool showSuccess = true,
      }) async {
    show(message: loadingMessage);

    try {
      final result = await operation();
      if (showSuccess && successMessage != null && successMessage.isNotEmpty) {
        Get.closeAllSnackbars();
        AppMessage.success(successMessage);
      }

      return result;
    } catch (e) {
      Get.closeAllSnackbars();
      AppMessage.error(errorMessage);
      debugPrint("AppLoading Error: $e");
      return null;
    } finally {
      hide();
    }
  }
}