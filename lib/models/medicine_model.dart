// models/medicine_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class MedicineModel {
  final String id;
  final String name;
  final String dosage;        // e.g., 500mg
  final String dose;          // e.g., 1 tablet
  final int stock;            // remaining quantity
  final String instructions;
  final String frequency;     // "3 times per day"
  final String howToTake;     // Empty Stomach / With Food
  final String alertMessage;
  final bool voiceAlert;

  final DateTime startDate;
  final DateTime endDate;
  final List<String> doseTimes; // ["08:00 AM", "02:00 PM", "08:00 PM"]

  final String imagePath;

  // NEW — Core Tracking Fields (Yeh sab ab zaroori hain)
  final int takenDoses;        // kitni doses li gayi
  final int missedDoses;       // kitni miss hui
  final int totalDoses;        // total expected = frequency × days
  final String status;         // ongoing | completed | completed_with_missed | stopped | completed_early
  final bool isActive;         // true = active tab, false = history tab
  final Timestamp? completionDate;

  final Timestamp createdAt;
  final Timestamp updatedAt;

  MedicineModel({
    required this.id,
    required this.name,
    required this.dosage,
    required this.dose,
    required this.stock,
    required this.instructions,
    required this.frequency,
    required this.howToTake,
    required this.alertMessage,
    required this.voiceAlert,
    required this.startDate,
    required this.endDate,
    required this.doseTimes,
    required this.imagePath,
    this.takenDoses = 0,
    this.missedDoses = 0,
    this.totalDoses = 0,
    this.status = 'ongoing',
    this.isActive = true,
    this.completionDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MedicineModel.fromMap(Map<String, dynamic> map, String id) {
    return MedicineModel(
      id: id,
      name: map['name'] ?? '',
      dosage: map['dosage'] ?? '',
      dose: map['dose'] ?? '',
      stock: map['stock'] ?? 0,
      instructions: map['instructions'] ?? '',
      frequency: map['frequency'] ?? '',
      howToTake: map['howToTake'] ?? 'With Food',
      alertMessage: map['alertMessage'] ?? "It's time to take your medicine!",
      voiceAlert: map['voiceAlert'] ?? false,

      startDate: (map['startDate'] as Timestamp).toDate(),
      endDate: (map['endDate'] as Timestamp).toDate(),
      doseTimes: List<String>.from(map['doseTimes'] ?? []),

      imagePath: map['imagePath'] ?? '',

      // NEW fields
      takenDoses: map['takenDoses'] ?? 0,
      missedDoses: map['missedDoses'] ?? 0,
      totalDoses: map['totalDoses'] ?? 0,
      status: map['status'] ?? 'ongoing',
      isActive: map['isActive'] ?? true,
      completionDate: map['completionDate'],

      createdAt: map['createdAt'] ?? Timestamp.now(),
      updatedAt: map['updatedAt'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dosage': dosage,
      'dose': dose,
      'stock': stock,
      'instructions': instructions,
      'frequency': frequency,
      'howToTake': howToTake,
      'alertMessage': alertMessage,
      'voiceAlert': voiceAlert,

      'startDate': Timestamp.fromDate(startDate),
      'endDate': Timestamp.fromDate(endDate),
      'doseTimes': doseTimes,
      'imagePath': imagePath,

      // NEW
      'takenDoses': takenDoses,
      'missedDoses': missedDoses,
      'totalDoses': totalDoses,
      'status': status,
      'isActive': isActive,
      'completionDate': completionDate,

      'createdAt': createdAt,
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }

  // Helper for UI
  bool get isCompleted => status == 'completed' || status == 'completed_with_missed' || status == 'completed_early';
  bool get isStopped => status == 'stopped';
  double get adherencePercentage =>
      totalDoses == 0 ? 0.0 : (takenDoses / totalDoses * 100).clamp(0.0, 100.0);
}