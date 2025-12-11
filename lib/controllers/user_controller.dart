import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../models/user_model.dart';  // Import your model

class UserController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Rx<UserModel?> userModel = Rx<UserModel?>(null);
  StreamSubscription<DocumentSnapshot>? _subscription;

  @override
  void onInit() {
    super.onInit();
    if (_auth.currentUser != null) {
      getUserProfileStream();
    }
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        getUserProfileStream();
      } else {
        userModel.value = null;
      }
    });
  }

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }

  // GET USER PROFILE DATA (Real-time Stream)
  void getUserProfileStream() {
    if (_auth.currentUser == null) return;
    final uid = _auth.currentUser!.uid;

    _subscription?.cancel();
    _subscription = _firestore.collection("users").doc(uid).snapshots().listen(
          (snapshot) {
        if (snapshot.exists) {
          userModel.value = UserModel.fromMap(snapshot.data()!, uid);
        } else {
          userModel.value = null;
        }
      },
      onError: (error) {
        if (kDebugMode) {
          print('Error fetching user data: $error');
        }
        userModel.value = null;
      },
    );
  }

  // Update Profile
  Future<void> updateProfile({
    String? userName,
    String? dateOfBirth,
    String? gender,
    String? profile,
  })
  async {
    if (_auth.currentUser == null) return;
    final uid = _auth.currentUser!.uid;
    Map<String, dynamic> updateData = {};
    if (userName != null) updateData["userName"] = userName;
    if (dateOfBirth != null) updateData["dateOfBirth"] = dateOfBirth;
    if (gender != null) updateData["gender"] = gender;
    updateData["profile"] = profile;
    try {
      await _firestore.collection("users").doc(uid).update(updateData);
      Get.back();
    } catch (e) {
      Get.snackbar('Error', 'Failed to update: $e');
    }
  }
  Stream<DocumentSnapshot> get userStream =>
      _firestore.collection("users").doc(_auth.currentUser!.uid).snapshots();
}