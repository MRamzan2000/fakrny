// services/dose_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DoseService {
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> markDoseAsTaken(String medicineId) async {
    await _firestore.runTransaction((tx) async {
      final ref = _firestore.collection('users').doc(uid).collection('medicines').doc(medicineId);
      final snap = await tx.get(ref);
      final data = snap.data()!;

      int stock = data['stock'] ?? 0;
      int taken = data['takenDoses'] ?? 0;

      tx.update(ref, {
        'stock': stock - 1,
        'takenDoses': taken + 1,
      });

      if (stock - 1 <= 0) {
        tx.update(ref, {
          'status': 'completed',
          'isActive': false,
        });
      }
    });
  }

  Future<void> runDailyChecker() async {
    final snapshot = await _firestore.collection('users').doc(uid).collection('medicines').get();
    final batch = _firestore.batch();

    for (var doc in snapshot.docs) {
      final data = doc.data();
      final endDate = (data['endDate'] as Timestamp).toDate();
      final stock = data['stock'] ?? 0;

      if (DateTime.now().isAfter(endDate.add(const Duration(days: 1))) || stock <= 0) {
        batch.update(doc.reference, {
          'isActive': false,
          'status': stock <= 0 ? 'completed' : 'completed_with_missed',
        });
      }
    }
    await batch.commit();
  }
}