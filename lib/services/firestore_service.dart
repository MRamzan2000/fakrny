import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fakrny/models/medicine_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  DateTime _parseDoseDateTime(String dateStr, String timeStr) {
    try {
      return DateFormat('yyyy-MM-dd HH:mm').parse('$dateStr $timeStr');
    } catch (_) {
      return DateFormat('yyyy-MM-dd hh:mm a').parse('$dateStr $timeStr');
    }
  }
  Stream<List<MedicineModel>> getMedicinesStream() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) throw Exception('User not authenticated');
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('medicines')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => MedicineModel.fromMap(doc.data(), doc.id))
        .toList());
  }
  Stream<QuerySnapshot> getDosesStreamForDate(String medicineId, String dateStr) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) throw Exception('User not authenticated');
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('medicines')
        .doc(medicineId)
        .collection('doses')
        .where('date', isEqualTo: dateStr)
        .snapshots();
  }
  Future<QuerySnapshot> getDosesForDate(String medicineId, String dateStr) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) throw Exception('User not authenticated');
    return await _firestore
        .collection('users')
        .doc(uid)
        .collection('medicines')
        .doc(medicineId)
        .collection('doses')
        .where('date', isEqualTo: dateStr)
        .get();
  }
  Future<void> markPastPendingDosesAsMissed() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) throw Exception('User not authenticated');

    final nowUtc = DateTime.now().toUtc();

    final activeMedsSnap = await _firestore
        .collection('users')
        .doc(uid)
        .collection('medicines')
        .where('isActive', isEqualTo: true)
        .get();

    for (var medDoc in activeMedsSnap.docs) {
      final medId = medDoc.id;
      final medRef = medDoc.reference;
      final medData = medDoc.data();
      final endTimestamp = medData['endDate'] as Timestamp?;
      final endDateUtc = endTimestamp?.toDate().toUtc();

      final pendingDosesSnap = await medRef
          .collection('doses')
          .where('status', isEqualTo: 'pending')
          .get();
      if (pendingDosesSnap.docs.isEmpty) continue;

      int missedCount = 0;
      WriteBatch batch = _firestore.batch();
      int ops = 0;

      final isAfterEnd = (endDateUtc != null)
          ? nowUtc.isAfter(endDateUtc.add(const Duration(days: 1)))
          : false;

      for (var doseDoc in pendingDosesSnap.docs) {
        final doseData = doseDoc.data();
        Timestamp? dtTimestamp = doseData['dateTime'] as Timestamp?;
        DateTime doseDateTimeUtc;

        if (dtTimestamp != null) {
          doseDateTimeUtc = dtTimestamp.toDate().toUtc();
        } else {
          // fallback: parse strings (less preferred)
          final dateStr = doseData['date'] as String? ?? '';
          final timeStr = doseData['time'] as String? ?? '';
          try {
            doseDateTimeUtc = _parseDoseDateTime(dateStr, timeStr).toUtc();
          } catch (e) {
            // if parse fails, treat as past to be safe
            doseDateTimeUtc = DateTime.utc(1970);
          }
        }

        if (isAfterEnd || doseDateTimeUtc.isBefore(nowUtc)) {
          batch.update(doseDoc.reference, {
            'status': 'missed',
            'missedAt': FieldValue.serverTimestamp(),
          });
          missedCount++;
          ops++;
        }

        if (ops >= 400) {
          await batch.commit();
          batch = _firestore.batch();
          ops = 0;
        }
      }

      if (missedCount > 0) {
        batch.update(medRef, {'missedDoses': FieldValue.increment(missedCount)});
      }
      if (ops > 0 || missedCount > 0) {
        await batch.commit();
        // Check for completion after updates
        await _completeMedicineIfNeeded(medId);
      }
    }
  }
  Future<void> _completeMedicineIfNeeded(String medicineId) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) throw Exception('User not authenticated');

    await _firestore.runTransaction((transaction) async {
      final medRef = _firestore
          .collection('users')
          .doc(uid)
          .collection('medicines')
          .doc(medicineId);
      final medSnap = await transaction.get(medRef);
      if (!medSnap.exists) return;
      final medData = medSnap.data();
      if (medData == null || !(medData['isActive'] ?? false)) return;

      final endTimestamp = medData['endDate'] as Timestamp?;
      final endDate = endTimestamp?.toDate();
      final takenDoses = (medData['takenDoses'] ?? 0) as num;
      final totalDoses = (medData['totalDoses'] ?? 0) as num;
      final stock = (medData['stock'] ?? 0) as num;
      final nowUtc = DateTime.now().toUtc();
      bool shouldComplete = false;
      String completionStatus = 'completed';

      if (endDate != null && nowUtc.isAfter(endDate.toUtc().add(const Duration(days: 1)))) {
        shouldComplete = true;
        final missed = totalDoses - takenDoses;
        if (missed > 0) completionStatus = 'completed_with_missed';
      } else if (stock <= 0) {
        shouldComplete = true;
        completionStatus = 'completed';
      }
      if (shouldComplete) {
        transaction.update(medRef, {
          'status': completionStatus,
          'isActive': false,
          'completionDate': FieldValue.serverTimestamp(),
        });
      }
    });
  }
  Future<DocumentReference> addMedicine(Map<String, dynamic> data) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) throw Exception('User not authenticated');
    return await _firestore
        .collection('users')
        .doc(uid)
        .collection('medicines')
        .add(data);
  }
  Future<void> updateMedicine(String id, Map<String, dynamic> data) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) throw Exception('User not authenticated');
    await _firestore
        .collection('users')
        .doc(uid)
        .collection('medicines')
        .doc(id)
        .update(data);
  }
  Future<void> deleteMedicine(String id) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) throw Exception('User not authenticated');
    await _firestore
        .collection('users')
        .doc(uid)
        .collection('medicines')
        .doc(id)
        .delete();
  }
  Future<void> createAllDoseDocuments(
      String medicineId,
      DateTime startDate,
      DateTime endDate,
      List<String> doseTimes,
      )
  async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) throw Exception('User not authenticated');

    final collectionRef = _firestore
        .collection('users')
        .doc(uid)
        .collection('medicines')
        .doc(medicineId)
        .collection('doses');

    int ops = 0;
    WriteBatch batch = _firestore.batch();

    DateTime currentDay = DateTime(startDate.year, startDate.month, startDate.day);
    while (!currentDay.isAfter(endDate)) {
      final String dateStr = DateFormat('yyyy-MM-dd').format(currentDay);
      for (int i = 0; i < doseTimes.length; i++) {
        final String doseId = '${dateStr}_$i';
        final doseRef = collectionRef.doc(doseId);

        // Create a canonical UTC timestamp for the dose.
        DateTime doseDateTime;
        try {
          doseDateTime = _parseDoseDateTime(dateStr, doseTimes[i]);
        } catch (e) {
          // fallback: assume time as HH:mm
          doseDateTime = DateFormat('yyyy-MM-dd HH:mm').parse('$dateStr ${doseTimes[i]}');
        }
        final doseTimestamp = Timestamp.fromDate(doseDateTime.toUtc());

        batch.set(doseRef, {
          'date': dateStr,
          'time': doseTimes[i],
          'dateTime': doseTimestamp, // canonical timestamp
          'status': 'pending', // pending | taken | missed | cancelled
          'doseIndex': i,
          'createdAt': FieldValue.serverTimestamp(),
        });
        ops++;
        if (ops >= 400) {
          await batch.commit();
          batch = _firestore.batch();
          ops = 0;
        }
      }
      currentDay = currentDay.add(const Duration(days: 1));
    }
    if (ops > 0) await batch.commit();
  }
  Future<void> deleteAllDoseDocuments(String medicineId) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) throw Exception('User not authenticated');

    final dosesSnap = await _firestore
        .collection('users')
        .doc(uid)
        .collection('medicines')
        .doc(medicineId)
        .collection('doses')
        .get();

    final batch = _firestore.batch();
    int ops = 0;
    WriteBatch writeBatch = _firestore.batch();
    for (var doc in dosesSnap.docs) {
      writeBatch.delete(doc.reference);
      ops++;
      if (ops >= 400) {
        await writeBatch.commit();
        writeBatch = _firestore.batch();
        ops = 0;
      }
    }
    if (ops > 0) await writeBatch.commit();
  }
  Future<void> markDoseAsTaken(String medicineId, String doseId) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) throw Exception('User not authenticated');

    final medRef = _firestore
        .collection('users')
        .doc(uid)
        .collection('medicines')
        .doc(medicineId);
    final doseRef = medRef.collection('doses').doc(doseId);

    await _firestore.runTransaction((transaction) async {
      final doseSnap = await transaction.get(doseRef);
      if (!doseSnap.exists) return;
      final doseData = doseSnap.data()!;
      final status = doseData['status'] as String?;
      if (status != 'pending') return; // already handled

      final medSnap = await transaction.get(medRef);
      if (!medSnap.exists) return;
      final medData = medSnap.data()!;
      final currentStock = (medData['stock'] ?? 0) as int;
      final currentTaken = (medData['takenDoses'] ?? 0) as int;
      final totalDoses = (medData['totalDoses'] ?? 0) as int;
      final endTimestamp = medData['endDate'] as Timestamp?;
      final endDate = endTimestamp?.toDate();

      // Compute new counters
      final newStock = currentStock - 1;
      final newTaken = currentTaken + 1;

      // Update dose and medicine
      transaction.update(doseRef, {
        'status': 'taken',
        'takenAt': FieldValue.serverTimestamp(),
      });

      transaction.update(medRef, {
        'takenDoses': FieldValue.increment(1),
        'stock': FieldValue.increment(-1),
      });

      // Completion logic
      bool shouldComplete = false;
      String completionStatus = 'completed';
      final nowUtc = DateTime.now().toUtc();
      if (newStock <= 0) {
        shouldComplete = true;
      } else if (newTaken >= totalDoses) {
        shouldComplete = true;
      } else if (endDate != null && nowUtc.isAfter(endDate.toUtc().add(const Duration(days: 1)))) {
        shouldComplete = true;
        final missed = totalDoses - newTaken;
        if (missed > 0) completionStatus = 'completed_with_missed';
      }

      if (shouldComplete) {
        transaction.update(medRef, {
          'status': completionStatus,
          'isActive': false,
          'completionDate': FieldValue.serverTimestamp(),
        });
      }
    });
  }
  Future<void> markDoseAsMissed(String medicineId, String doseId) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) throw Exception('User not authenticated');

    await _firestore.runTransaction((transaction) async {
      final doseRef = _firestore
          .collection('users')
          .doc(uid)
          .collection('medicines')
          .doc(medicineId)
          .collection('doses')
          .doc(doseId);
      final doseSnap = await transaction.get(doseRef);
      if (!doseSnap.exists) return;
      if (doseSnap['status'] != 'pending') return;
      transaction.update(doseRef, {
        'status': 'missed',
        'missedAt': FieldValue.serverTimestamp(),
      });

      transaction.update(
        _firestore
            .collection('users')
            .doc(uid)
            .collection('medicines')
            .doc(medicineId),
        {
          'missedDoses': FieldValue.increment(1),
        },
      );
    });
  }
  Future<void> stopMedicineProper(String medicineId) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) throw Exception('User not authenticated');

    final medRef = _firestore
        .collection('users')
        .doc(uid)
        .collection('medicines')
        .doc(medicineId);
    final pendingDosesSnap = await medRef
        .collection('doses')
        .where('status', isEqualTo: 'pending')
        .get();

    if (pendingDosesSnap.docs.isEmpty) {
      // Just update med status
      await medRef.update({
        'status': 'stopped',
        'isActive': false,
        'stoppedAt': FieldValue.serverTimestamp(),
      });
      return;
    }

    int missedCount = 0;
    int ops = 0;
    WriteBatch batch = _firestore.batch();
    final nowUtc = DateTime.now().toUtc();

    for (var doseDoc in pendingDosesSnap.docs) {
      final doseData = doseDoc.data();
      Timestamp? ts = doseData['dateTime'] as Timestamp?;
      DateTime doseDateTimeUtc;
      if (ts != null) {
        doseDateTimeUtc = ts.toDate().toUtc();
      } else {
        final dateStr = doseData['date'] as String? ?? '';
        final timeStr = doseData['time'] as String? ?? '';
        try {
          doseDateTimeUtc = _parseDoseDateTime(dateStr, timeStr).toUtc();
        } catch (e) {
          doseDateTimeUtc = DateTime.utc(1970);
        }
      }

      if (doseDateTimeUtc.isBefore(nowUtc)) {
        batch.update(doseDoc.reference, {'status': 'missed', 'missedAt': FieldValue.serverTimestamp()});
        missedCount++;
      } else {
        batch.update(doseDoc.reference, {'status': 'cancelled'});
      }
      ops++;
      if (ops >= 400) {
        await batch.commit();
        batch = _firestore.batch();
        ops = 0;
      }
    }

    // Final update on medicine doc (increment missed once and set stopped)
    final medUpdate = <String, dynamic>{
      'status': 'stopped',
      'isActive': false,
      'stoppedAt': FieldValue.serverTimestamp(),
    };
    if (missedCount > 0) medUpdate['missedDoses'] = FieldValue.increment(missedCount);

    batch.update(medRef, medUpdate);
    await batch.commit();
  }
  Future<MedicineModel?> getMedicineById(String id) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) throw Exception('User not authenticated');
    final doc = await _firestore
        .collection('users')
        .doc(uid)
        .collection('medicines')
        .doc(id)
        .get();
    if (!doc.exists) return null;
    return MedicineModel.fromMap(doc.data()!, doc.id);
  }
  Future<void> updateDailyStatistics(DateTime date, bool isTaken) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) throw Exception('User not authenticated');
    final dateStr = DateFormat('yyyy-MM-dd').format(date);
    final statsRef = _firestore
        .collection('users')
        .doc(uid)
        .collection('statistics')
        .doc(dateStr);
    if (isTaken) {
      await statsRef.set({'taken': FieldValue.increment(1)}, SetOptions(merge: true));
    } else {
      await statsRef.set({'missed': FieldValue.increment(1)}, SetOptions(merge: true));
    }
    await statsRef.set({'total': FieldValue.increment(1)}, SetOptions(merge: true));
  }
}
