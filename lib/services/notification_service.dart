// services/notification_service.dart

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:get/get.dart';
import 'package:fakrny/services/firestore_service.dart'; // add this
import 'package:flutter_tts/flutter_tts.dart'; // TTS ke liye

class NotificationService {
  final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();
  final FirestoreService _firestore = FirestoreService();
  final FlutterTts _flutterTts = FlutterTts();

  // TTS init
  Future<void> _initTts() async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);
  }

  Future<void> init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: android);

    await _notifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        final String? payload = response.payload;
        if (payload != null && payload.isNotEmpty) {
          await _handleNotificationClick(payload);
        }
      },
    );

    await _initTts();
  }

  // Payload handle karne ke liye
  Future<void> _handleNotificationClick(String payload) async {
    final parts = payload.split('|');

    // Case 1: Normal dose reminder click → mark as taken
    if (parts.length == 2) {
      final medicineId = parts[0];
      final doseId = parts[1];

      await _firestore.markDoseAsTaken(medicineId, doseId);

      // Voice alert
      final med = await _firestore.getMedicineById(medicineId);
      if (med != null && med.voiceAlert) {
        await _flutterTts.speak("You have taken ${med.dose} ${med.name}");
      }

      Get.snackbar("Success", "Dose marked as taken");
    }

    // Case 2: AUTO_MISS silent notification
    else if (parts[0] == 'AUTO_MISS' && parts.length == 3) {
      final medicineId = parts[1];
      final doseId = parts[2];

      await _firestore.markDoseAsMissed(medicineId, doseId);

      // Optional: TTS for missed
      final med = await _firestore.getMedicineById(medicineId);
      if (med != null && med.voiceAlert) {
        await _flutterTts.speak("You missed your ${med.name} dose");
      }
    }
  }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime dateTime,
    String? payload,
  }) async {
    final androidDetails = AndroidNotificationDetails(
      'dose_channel',
      'Medicine Reminders',
      importance: Importance.max,
      priority: Priority.high,
      playSound: title.isNotEmpty,
      enableVibration: title.isNotEmpty,
      showWhen: true,
    );

    await _notifications.zonedSchedule(
      id,
      title.isEmpty ? null : title,
      body.isEmpty ? null : body,
      tz.TZDateTime.from(dateTime, tz.local),
      NotificationDetails(android: androidDetails),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: payload,
    );
  }

  Future<void> cancelAllForMedicine(String medicineId) async {
    for (int i = 0; i < 3000; i++) {
      await _notifications.cancel(medicineId.hashCode.abs() + i);
    }
    await _notifications.cancelAll();
  }
}