import 'package:fakrny/models/gender_model.dart';
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
  Rx<GenderModel?> selectedGender = Rx<GenderModel?>(null);

  RxBool remember = false.obs;
  RxBool obscure = true.obs;

  void toggleRemember() {
    remember.value = !remember.value;
  }
  List<GenderModel> genderList = [
    GenderModel(name: "Male"),
    GenderModel(name: "Female"),
    GenderModel(name: "Custom"),
  ];
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