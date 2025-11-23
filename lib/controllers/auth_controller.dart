import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AuthController extends GetxController {
  // SignUp Controllers
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final confirmPassCtrl = TextEditingController();

  // Forgot Password Controller
  final forgotEmailCtrl = TextEditingController();
  // New Password Created Controller
  final newPasswordCtrl = TextEditingController();
  final confirmNewPasswordCtrl = TextEditingController();

  RxBool remember = false.obs;
  RxBool obscure = true.obs;

  void toggleRemember() {
    remember.value = !remember.value;
  }

  void toggleObscure() {
    obscure.value = !obscure.value;
  }

  @override
  void onClose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    passCtrl.dispose();
    confirmPassCtrl.dispose();
    forgotEmailCtrl.dispose();
    newPasswordCtrl.dispose();
    confirmNewPasswordCtrl.dispose();
    super.onClose();
  }
}