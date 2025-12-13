import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fakrny/models/medicine_model.dart';
import 'package:fakrny/services/firestore_service.dart';
import 'package:fakrny/services/image_service.dart';
import 'package:fakrny/utils/app_loadings.dart';
import 'package:fakrny/utils/app_message.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MedicineController extends GetxController {
  // Services
  final FirestoreService firestore = FirestoreService();
  final ImageService imageService = ImageService();

  // Lists
  RxList<MedicineModel> activeMedicines = <MedicineModel>[].obs;
  RxList<MedicineModel> historyMedicines = <MedicineModel>[].obs;
  StreamSubscription<List<MedicineModel>>? _medicineSubscription;

  // Form Controllers
  final name = TextEditingController();
  final dosage = TextEditingController();
  final dose = TextEditingController();
  final stock = TextEditingController();
  final instructions = TextEditingController();

  // Reactive
  var frequency = '1 time per day'.obs;
  var howToTake = 'With Food'.obs;
  var voiceAlert = false.obs;
  var isLoading = false.obs;
  var startDate = DateTime.now().obs;
  var endDate = DateTime.now().add(const Duration(days: 7)).obs;
  var doseTimes = List.generate(6, (_) => ''.obs).obs;
  final frequencyOptions = [
    '1 time per day',
    '2 times per day',
    '3 times per day',
    '4 times per day',
    '5 times per day',
    '6 times per day',
  ];
  final howToTakeOptions = ['Empty Stomach', 'With Food', 'After Meal'];
  RxnString selectedImagePath = RxnString();

  @override
  void onInit() {
    super.onInit();
    _listenToMedicines();
    stock.addListener(autoCalculateEndDate);
    frequency.listen((_) {
      autoCalculateEndDate();
      _autoFillTimes();
    });
    _autoFillTimes();
  }

  @override
  void onClose() {
    _medicineSubscription?.cancel();
    stock.removeListener(autoCalculateEndDate);

    name.dispose();
    dosage.dispose();
    dose.dispose();
    stock.dispose();
    instructions.dispose();
    super.onClose();
  }
  void autoCalculateEndDate() {
    if (stock.text.isEmpty || int.tryParse(stock.text.trim()) == null) {
      return;
    }
    final int totalStock = int.parse(stock.text.trim());
    final freqCount = int.tryParse(frequency.value.split(' ')[0]) ?? 1;
    if (freqCount == 0) return;
    final int daysRequired = (totalStock / freqCount).ceil();
    // Make endDate inclusive of start day
    endDate.value = startDate.value.add(Duration(days: daysRequired - 1));
  }
  Map<String, dynamic> _getMedicineMap() {
    final freqCount = int.parse(frequency.value.split(' ')[0]);
    final days = endDate.value.difference(startDate.value).inDays + 1;
    final totalDoses = freqCount * days;
    return {
      'name': name.text.trim(),
      'dosage': dosage.text.trim(),
      'dose': dose.text.trim(),
      'instructions': instructions.text.trim(),
      'frequency': frequency.value,
      'howToTake': howToTake.value,
      'voiceAlert': voiceAlert.value,
      'startDate': Timestamp.fromDate(DateTime(startDate.value.year, startDate.value.month, startDate.value.day)),
      'endDate': Timestamp.fromDate(DateTime(endDate.value.year, endDate.value.month, endDate.value.day)),
      'doseTimes': doseTimes.map((e) => e.value.trim()).where((t) => t.isNotEmpty).toList(),
      'imagePath': selectedImagePath.value ?? '',
      'stock': int.parse(stock.text.trim()),
      'takenDoses': 0,
      'missedDoses': 0,
      'totalDoses': totalDoses,
      'status': 'ongoing',
      'isActive': true,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
  void clearFormPublic() {
    name.clear();
    dosage.clear();
    dose.clear();
    stock.clear();
    instructions.clear();
    selectedImagePath.value = null;
    frequency.value = frequencyOptions[0];
    howToTake.value = howToTakeOptions[0];
    voiceAlert.value = false;
    startDate.value = DateTime.now();
    endDate.value = DateTime.now().add(const Duration(days: 7));
    for (var t in doseTimes) {
      t.value = '';
    }
    _autoFillTimes();
  }
  void _listenToMedicines() {
    _medicineSubscription = firestore.getMedicinesStream().listen((all) {
      activeMedicines.assignAll(all.where((m) => m.isActive).toList());
      historyMedicines.assignAll(all.where((m) => !m.isActive).toList());
    }, onError: (e) {
      if (kDebugMode) {
        print('Medicines stream error: $e');
      }
    });
  }
  void _autoFillTimes() {
    final count = int.parse(frequency.value.split(' ')[0]);
    final now = TimeOfDay.now();
    final gap = 24 / count;
    List<String> generated = [];
    double currentHour = now.hour + now.minute / 60.0;
    for (int i = 0; i < count; i++) {
      double hour = (currentHour + (gap * i)) % 24;
      final time = TimeOfDay(
        hour: hour.floor(),
        minute: ((hour - hour.floor()) * 60).round(),
      );
      generated.add(_formatTime(time));
    }
    for (int i = 0; i < 6; i++) {
      doseTimes[i].value = i < generated.length ? generated[i] : '';
    }
  }
  String _formatTime(TimeOfDay t) {
    final hour = t.hourOfPeriod == 0 ? 12 : t.hourOfPeriod;
    final minute = t.minute.toString().padLeft(2, '0');
    final period = t.period == DayPeriod.am ? "AM" : "PM";
    return "$hour:$minute $period";
  }
  void onFrequencyChanged(String v) {
    frequency.value = v;
    _autoFillTimes();
    autoCalculateEndDate();
  }
  Future<void> addMedicine() async {
    if (!_validateForm()) return;

    await AppLoader.start(
          () async {
        final data = _getMedicineMap();
        final docRef = await firestore.addMedicine(data);

        await firestore.createAllDoseDocuments(
          docRef.id,
          startDate.value,
          endDate.value,
          List<String>.from(data['doseTimes']),
        );

        clearFormPublic();
        Get.back();
      },
      loadingMessage: "Adding medicine...",
      successMessage: "Medicine added successfully!",
      errorMessage: "Failed to add medicine",
    );
  }
  Future<void> updateMedicine(String medicineId) async {
    if (!_validateForm()) return;

    await AppLoader.start(
          () async {
        final data = _getMedicineMap();
        data.remove('createdAt');
        await firestore.updateMedicine(medicineId, data);
        await firestore.deleteAllDoseDocuments(medicineId);
        await firestore.createAllDoseDocuments(
          medicineId,
          startDate.value,
          endDate.value,
          List<String>.from(data['doseTimes']),
        );
        Get.back();
      },
      loadingMessage: "Updating medicine...",
      successMessage: "Medicine updated successfully!",
      errorMessage: "Failed to update medicine",
    );
  }
  Future<void> deleteMedicine(String medicineId) async {
    await AppLoader.start(
          () async {
        final med = await firestore.getMedicineById(medicineId);
        if (med != null) {
          await firestore.deleteAllDoseDocuments(medicineId);
          await firestore.deleteMedicine(medicineId);
        }
      },
      loadingMessage: "Deleting medicine...",
      successMessage: "Medicine deleted!",
      errorMessage: "Failed to delete medicine",
    );
  }
  Future<void> stopMedicine(String medicineId) async {
    await AppLoader.start(
          () => firestore.stopMedicineProper(medicineId),
      loadingMessage: "Stopping medicine...",
      successMessage: "Medicine stopped",
      errorMessage: "Failed to stop medicine",
    );
  }
  Future<void> loadMedicineForEdit(String medicineId) async {
    await AppLoader.start(
          () async {
        final med = await firestore.getMedicineById(medicineId);
        if (med == null) throw "Medicine not found";

        name.text = med.name;
        dosage.text = med.dosage;
        dose.text = med.dose;
        stock.text = med.stock.toString();
        instructions.text = med.instructions ?? '';
        frequency.value = med.frequency;
        howToTake.value = med.howToTake;
        voiceAlert.value = med.voiceAlert;
        startDate.value = med.startDate;
        endDate.value = med.endDate;
        selectedImagePath.value = med.imagePath.isNotEmpty ? med.imagePath : null;

        final times = med.doseTimes;
        for (int i = 0; i < 6; i++) {
          doseTimes[i].value = i < times.length ? times[i] : '';
        }
        autoCalculateEndDate();
      },
      loadingMessage: "Loading medicine details...",
      errorMessage: "Failed to load medicine",
      showSuccess: false,
    );
  }
  Future<void> markDoseAsTaken(String medicineId, String doseId) async {
    try {
      await firestore.markDoseAsTaken(medicineId, doseId);
      await firestore.updateDailyStatistics(DateTime.now(), true);
      AppMessage.success("dose_taken".tr);
      // Refresh UI
    } catch (e, st) {
      if (kDebugMode) {
        print('Failed markDoseAsTaken: $e\n$st');
      }
      AppMessage.error("Failed to mark dose as taken");
    }
  }
  Future<void> markDoseAsMissed(String medicineId, String doseId) async {
    try {
      await firestore.markDoseAsMissed(medicineId, doseId);
      await firestore.updateDailyStatistics(DateTime.now(), false);
      AppMessage.error("dose_skipped".tr);
    } catch (e, st) {
      if (kDebugMode) {
        print('Failed markDoseAsMissed: $e\n$st');
      }
      AppMessage.error("Failed to skip dose");
    }
  }




  // VALIDATION
  bool _validateForm() {
    if (name.text.trim().isEmpty) return _error("Enter medicine name");
    if (dosage.text.trim().isEmpty) return _error("Enter strength");
    if (dose.text.trim().isEmpty) return _error("Enter dose per intake");
    if (stock.text.trim().isEmpty ||
        int.tryParse(stock.text.trim()) == null ||
        int.parse(stock.text.trim()) <= 0) {
      return _error("Enter valid quantity");
    }
    if (endDate.value.isBefore(startDate.value)) {
      return _error("End date cannot be before start");
    }
    final filled = doseTimes.where((t) => t.value.trim().isNotEmpty).length;
    if (filled < int.parse(frequency.value.split(' ')[0])) {
      return _error("Set all reminder times");
    }
    return true;
  }

  bool _error(String msg) {
    AppMessage.error(msg);
    return false;
  }

  // IMAGE PICKER
  Future<void> pickFromGallery() async {
    final path = await imageService.pickFromGallery();
    if (path != null) selectedImagePath.value = path;
  }

  Future<void> pickFromCamera() async {
    final path = await imageService.pickFromCamera();
    if (path != null) selectedImagePath.value = path;
  }
}
