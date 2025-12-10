import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Rx user data
  RxMap<String, dynamic> userData = <String, dynamic>{}.obs;

  // ADD USER DATA ON SIGN UP
  Future<void> addUserData({
    required String userName,
    required String dateOfBirth,
    required String gender,
  }) async {
    final uid = _auth.currentUser!.uid;
    final email = _auth.currentUser!.email;

    await _firestore.collection("users").doc(uid).set({
      "userId": uid,
      "userName": userName,
      "dateOfBirth": dateOfBirth,
      "gender": gender,
      "email": email,
      "createdAt": DateTime.now().toIso8601String(),
    });
  }

  // GET USER PROFILE DATA
  Future<void> getUserProfile() async {
    final uid = _auth.currentUser!.uid;

    final doc =
    await _firestore.collection("users").doc(uid).get();

    if (doc.exists) {
      userData.value = doc.data()!;
    }
  }

  // UPDATE PROFILE (EDIT PROFILE)
  Future<void> updateProfile({
    String? userName,
    String? dateOfBirth,
    String? gender,
  }) async {
    final uid = _auth.currentUser!.uid;

    Map<String, dynamic> updateData = {};

    if (userName != null) updateData["userName"] = userName;
    if (dateOfBirth != null) updateData["dateOfBirth"] = dateOfBirth;
    if (gender != null) updateData["gender"] = gender;

    await _firestore.collection("users").doc(uid).update(updateData);

    await getUserProfile();
  }
}
