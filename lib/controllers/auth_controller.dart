import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fakrny/utils/app_loadings.dart';
import 'package:fakrny/utils/app_message.dart';
import 'package:fakrny/utils/app_validator.dart';
import 'package:fakrny/utils/my_shared_pref.dart';
import 'package:fakrny/views/screens/auth_screens/login_screen.dart';
import 'package:fakrny/views/screens/auth_screens/verify_email_screen.dart';
import 'package:fakrny/views/screens/auth_screens/verify_otp_screen.dart';
import 'package:fakrny/views/screens/bottom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  RxBool isEmailVerified = false.obs;
  Timer? emailCheckTimer;
  RxBool remember = false.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // SAVE USER DATA TO FIRESTORE
  Future<void> saveUserToFirestore({
    required String uid,
    required String name,
    required String email,
    required String gender,
    required String dob,
  }) async {
    await FirebaseFirestore.instance.collection("users").doc(uid).set({
      "userId": uid,
      "userName": name,
      "email": email,
      "gender": gender,
      "dateOfBirth": dob,
      "createdAt": DateTime.now().toIso8601String(),
    });
  }

  // SIGN UP
  Future<void> signUpUser({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required dynamic gender,
    required Rx<DateTime?> dob,
  }) async {
    final errors = [
      AppValidator.validateName(name),
      AppValidator.validateEmail(email),
      AppValidator.validatePassword(password),
      AppValidator.validateConfirmPassword(password, confirmPassword),
      AppValidator.validateGender(gender),
      AppValidator.validateDob(dob.value),
    ];

    for (var e in errors) {
      if (e != null) return AppMessage.error(e);
    }

    try {
      AppLoader.show(message: "Creating your account...");

      final userCred = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      await userCred.user!.sendEmailVerification();

      AppMessage.success("Verification email sent!");

      // Move to VerifyEmailScreen
      Get.off(() => VerifyEmailScreen(
        name: name,
        email: email,
        dob: dob,
        gender: gender, uid: userCred.user?.uid??"",
      ));
    } on FirebaseAuthException catch (e) {
      final msg = switch (e.code) {
        'weak-password' => "Password is too weak.",
        'email-already-in-use' => "Email already exists.",
        'invalid-email' => "Invalid email format.",
        _ => "Failed to create account. Try again.",
      };
      AppMessage.error(msg);
    } finally {
      AppLoader.hide();
    }
  }

  // VERIFICATION LISTENER (FIXED)
  void startEmailVerificationListener({
    required String name,
    required String email,
    required dynamic gender,
    required Rx<DateTime?> dob,
  }) {
    emailCheckTimer?.cancel();

    emailCheckTimer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      final user = FirebaseAuth.instance.currentUser;
      await user?.reload();

      if (user != null && user.emailVerified) {
        isEmailVerified.value = true; // UI will handle navigation
        timer.cancel();

        // Save user data in Firestore
        await saveUserToFirestore(
          uid: user.uid,
          name: name,
          email: email,
          gender: gender.toString(),
          dob: dob.value.toString(),
        );
      }
    });
  }

  // LOGIN
  Future<void> loginWithEmail({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    final emailErr = AppValidator.validateEmail(email);
    if (emailErr != null) return AppMessage.error(emailErr);

    final passErr = AppValidator.validatePassword(password);
    if (passErr != null) return AppMessage.error(passErr);

    try {
      AppLoader.show(message: "Logging in...");

      final userCred = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      final user = userCred.user;
      if (user == null) return AppMessage.error("Login failed.");

      if (!user.emailVerified) {
        return AppMessage.error("Please verify your email first.");
      }

      if (rememberMe) {
        SharedPrefHelper.setLogin(true);
        SharedPrefHelper.saveUser(uid: user.uid, email: user.email ?? "");
      }

      AppMessage.success("Welcome back!");
      Get.offAll(() => BottomBar());
    } on FirebaseAuthException catch (e) {
      String msg;
      switch (e.code) {
        case "invalid-credential":
          msg = "Invalid email or password.";
          break;
        case "too-many-requests":
          msg = "Too many attempts. Try again later.";
          break;
        case "network-request-failed":
          msg = "No internet connection.";
          break;
        default:
          msg = "Login failed. Please try again.";
      }
      AppMessage.error(msg);
    } finally {
      AppLoader.hide();
    }
  }

  // GOOGLE LOGIN
  Future<void> signInWithGoogle() async {
    try {
      AppLoader.show(message: "Login With Google...");

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        AppLoader.hide();
        return;
      }

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);
      AppLoader.hide();

      if (userCredential.user != null) {
        SharedPrefHelper.setLogin(true);
        SharedPrefHelper.saveUser(
          uid: userCredential.user?.uid ?? "",
          email: userCredential.user?.email ?? "",
        );
        Get.offAll(() => BottomBar());
      }
    } catch (e) {
      AppLoader.hide();
      if (kDebugMode) print('Google Sign-In Error: $e');
    }
  }

  // RESEND VERIFICATION EMAIL
  Future<void> resendVerificationEmail() async {
    try {
      final user = _auth.currentUser;

      if (user != null && !user.emailVerified) {
        AppLoader.show(message: "Resending email...");
        await user.sendEmailVerification();
        AppMessage.success("Verification email sent!");
      } else if (user != null && user.emailVerified) {
        AppMessage.success("Email already verified.");
      } else {
        AppMessage.error("No logged-in user found.");
      }
    } catch (e) {
      AppMessage.error("Failed to resend email.");
    } finally {
      AppLoader.hide();
    }
  }

  // FORGOT PASSWORD
  Future<void> forgotPassword({required String email}) async {
    if (AppValidator.validateEmail(email) != null) {
      return AppMessage.error("Enter a valid email.");
    }

    try {
      AppLoader.show(message: "Sending reset email...");

      await _auth.sendPasswordResetEmail(email: email.trim());

      AppMessage.success("Reset email sent!");
      Get.to(() => VerifyOtpScreen());
    } on FirebaseAuthException catch (e) {
      AppMessage.error(
        e.code == 'user-not-found'
            ? "Email not registered."
            : "Failed to send reset email.",
      );
    } finally {
      AppLoader.hide();
    }
  }

  // CHANGE PASSWORD
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      AppLoader.show(message: "Updating password...");

      final user = _auth.currentUser;
      if (user == null || user.email == null) {
        return AppMessage.error("No user logged in.");
      }

      await user.reauthenticateWithCredential(
        EmailAuthProvider.credential(
          email: user.email!,
          password: currentPassword,
        ),
      );

      await user.updatePassword(newPassword);

      AppMessage.success("Password updated!");
    } on FirebaseAuthException catch (e) {
      final msg = switch (e.code) {
        'wrong-password' => "Your current password is incorrect.",
        'weak-password' => "New password is too weak.",
        _ => "Failed to update password.",
      };
      AppMessage.error(msg);
    } finally {
      AppLoader.hide();
    }
  }

  // DELETE ACCOUNT
  Future<void> deleteAccount() async {
    try {
      AppLoader.show(message: "Deleting account...");

      final user = _auth.currentUser;
      if (user == null) return AppMessage.error("No user logged in.");

      await user.delete();

      AppMessage.success("Account deleted.");
      Get.offAll(() => LoginScreen());
    } on FirebaseAuthException catch (e) {
      AppMessage.error(
        e.code == 'requires-recent-login'
            ? "Please log in again to delete your account."
            : "Unable to delete account.",
      );
    } finally {
      AppLoader.hide();
    }
  }

  @override
  void onClose() {
    emailCheckTimer?.cancel();
    super.onClose();
  }
}
