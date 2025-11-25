import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddMedicineController extends GetxController {

  // Text controllers
  final name = TextEditingController();
  final dosage = TextEditingController();
  final dose = TextEditingController();
  final stock = TextEditingController();
  final instructions = TextEditingController();
  final customAlert = TextEditingController();

  // Rx state variables
  var frequency = '4 times per day'.obs;
  var howToTake = 'Empty Stomach'.obs;
  var alertMessage = "It's time to take your white pill after you...".obs;
  var voiceAlert = false.obs;
  var customTextAlert = false.obs;

  // Dates
  var startDate = DateTime.now().obs;
  var endDate = DateTime.now().add(const Duration(days: 1)).obs;

  // Dose Times
  var doseTimes = List.generate(6, (_) => ''.obs);

  // Dropdown options
  final frequencyOptions = [
    '1 time per day',
    '2 times per day',
    '3 times per day',
    '4 times per day',
    '5 times per day',
    '6 times per day'
  ];

  final howToTakeOptions = ['Empty Stomach', 'With Food', 'After Meal'];

  final alertMessages = [
    "It's time to take your white pill after you...",
    "Time for your daily medication!",
    "Don't forget your pill now."
  ];

  final RxnString selectedImagePath = RxnString();

  final ImagePicker _picker = ImagePicker();

  /// Pick Image From Gallery
  Future<void> pickFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImagePath.value = image.path;
    }
  }

  /// Pick Image From Camera
  Future<void> pickFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      selectedImagePath.value = image.path;
    }
  }

  String formatTime(int hour) => hour < 12 ? 'AM' : 'PM';
}
