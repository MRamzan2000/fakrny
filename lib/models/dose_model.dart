// models/dose_model.dart (New file)
import 'package:cloud_firestore/cloud_firestore.dart';

class DoseModel {
  final String id;
  final String medicineId;
  final String medicineName;
  final String date;
  final String time;
  final String status;
  final int doseIndex;
  final DateTime? takenAt;
  final DateTime? missedAt;

  DoseModel({
    required this.id,
    required this.medicineId,
    required this.medicineName,
    required this.date,
    required this.time,
    required this.status,
    required this.doseIndex,
    this.takenAt,
    this.missedAt,
  });

  factory DoseModel.fromMap(
      Map<String, dynamic> map,
      String id, {
        required String medicineId,
        required String medicineName,
      }) {
    return DoseModel(
      id: id,
      medicineId: medicineId,
      medicineName: medicineName,
      date: map['date'] ?? '',
      time: map['time'] ?? '',
      status: map['status'] ?? 'pending',
      doseIndex: map['doseIndex'] ?? 0,
      takenAt: map['takenAt'] != null ? (map['takenAt'] as Timestamp).toDate() : null,
      missedAt: map['missedAt'] != null ? (map['missedAt'] as Timestamp).toDate() : null,
    );
  }
}