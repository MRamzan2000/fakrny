import 'dart:async';
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

class AuthController extends GetxController {
  /// Reactive email verification state
  RxBool isEmailVerified = false.obs;

  /// Timer for periodic email verification check
  Timer? emailCheckTimer;

  /// Reactive "remember me" for login screen
  RxBool remember = false.obs;


  /// SIGN UP USER
  Future<void> signUpUser({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required dynamic gender,
    required Rx<DateTime?> dob,
  })
  async {
    // Validate inputs
    final nameError = AppValidator.validateName(name);
    if (nameError != null) return AppMessage.error(nameError);

    final emailError = AppValidator.validateEmail(email);
    if (emailError != null) return AppMessage.error(emailError);

    final passwordError = AppValidator.validatePassword(password);
    if (passwordError != null) return AppMessage.error(passwordError);

    final confirmPasswordError =
    AppValidator.validateConfirmPassword(password, confirmPassword);
    if (confirmPasswordError != null) return AppMessage.error(confirmPasswordError);

    final genderError = AppValidator.validateGender(gender);
    if (genderError != null) return AppMessage.error(genderError);

    final dobError = AppValidator.validateDob(dob.value);
    if (dobError != null) return AppMessage.error(dobError);

    try {
      AppLoader.show(message: "Creating your account...");

      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      await userCredential.user!.sendEmailVerification();

      AppLoader.hide();
      AppMessage.success("Verification email sent!");
      Get.to(() => VerifyEmailScreen());
    } on FirebaseAuthException catch (e) {
      AppLoader.hide();
      String message = "Something went wrong";
      if (e.code == 'weak-password') message = "Password is too weak";
      if (e.code == 'email-already-in-use') message = "Email already exists";
      if (e.code == 'invalid-email') message = "Invalid email";
      AppMessage.error(message);
    } catch (e) {
      AppLoader.hide();
      AppMessage.error("Unexpected error occurred");
      if (kDebugMode) print(e);
    } finally {
      AppLoader.hide();
    }
  }


  /// LOGIN WITH EMAIL & PASSWORD
  Future<void> loginWithEmail({
    required String email,
    required String password,
    required bool rememberMe,
  })
  async {
    String? emailError = AppValidator.validateEmail(email);
    if (emailError != null) return AppMessage.error(emailError);

    String? passwordError = AppValidator.validatePassword(password);
    if (passwordError != null) return AppMessage.error(passwordError);

    try {
      AppLoader.show(message: "Logging in...");
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      final user = userCredential.user;

      if (user == null) {
        AppLoader.hide();
        return AppMessage.error("Something went wrong. Try again.");
      }
      if (!user.emailVerified) {
        AppLoader.hide();
        return AppMessage.error("Please verify your email first!");
      }
      if (rememberMe) {
        SharedPrefHelper.setLogin(true);
        SharedPrefHelper.saveUser(
          uid: user.uid,
          email: user.email ?? "",
        );
      }
      AppLoader.hide();
      AppMessage.success("Login successful!");
      Get.offAll(() => BottomBar());
    }
    on FirebaseAuthException catch (e) {
      AppLoader.hide();

      String message = "Login failed, please try again.";

      switch (e.code) {
        case 'user-not-found':
          message = "No user found with this email";
          break;

        case 'wrong-password':
        case 'invalid-credential':
          message = "Incorrect password";
          break;

        case 'too-many-requests':
          message = "Too many attempts, please try again later";
          break;

        case 'network-request-failed':
          message = "Network error, please check your connection";
          break;

        case 'invalid-email':
          message = "Invalid email format";
          break;
      }

      AppMessage.error(message);
    }
    catch (e) {
      AppLoader.hide();
      AppMessage.error("Unexpected error occurred");
    }
  }





  /// EMAIL VERIFICATION LISTENER
  void startEmailVerificationListener()
  {
    emailCheckTimer?.cancel(); // Ensure only one timer exists
    emailCheckTimer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      final user = FirebaseAuth.instance.currentUser;
      await user?.reload();

      if (user != null && user.emailVerified) {
        isEmailVerified.value = true;
        timer.cancel();
        if (Get.context != null) {
          AppMessage.success("Your email has been verified successfully!");
          Get.offAll(() => LoginScreen());
        }
      }
    });
  }


  /// RESEND EMAIL VERIFICATION
  Future<void> resendVerificationEmail()
  async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null && !user.emailVerified) {
        AppLoader.show(message: "Resending verification email...");
        await user.sendEmailVerification();
        AppLoader.hide();
        AppMessage.success("Verification email sent!");
      } else if (user != null && user.emailVerified) {
        AppMessage.success("Your email is already verified");
      } else {
        AppMessage.error("No user is currently logged in");
      }
    } catch (e) {
      AppLoader.hide();
      AppMessage.error("Failed to resend email");
      if (kDebugMode) print(e);
    }
  }


  /// FORGOT PASSWORD (SEND RESET EMAIL)
  Future<void> forgotPassword({required String email}) async {
    if (AppValidator.validateEmail(email) != null) {
      return AppMessage.error("Enter a valid email");
    }

    try {
      AppLoader.show(message: "Sending password reset email...");
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.trim());
      AppLoader.hide();
      AppMessage.success("Password reset email sent successfully!");
      Get.to(() => VerifyOtpScreen());
    } on FirebaseAuthException catch (e) {
      AppLoader.hide();
      String message = "Failed to send reset email";
      if (e.code == 'user-not-found') message = "No user found with this email";
      AppMessage.error(message);
    } catch (e) {
      AppLoader.hide();
      AppMessage.error("Unexpected error occurred");
      if (kDebugMode) print(e);
    } finally {
      AppLoader.hide();
    }
  }

  /// CHANGE PASSWORD
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  })
  async {
    try {
      AppLoader.show(message: "Updating password...");
      final user = FirebaseAuth.instance.currentUser;

      if (user == null || user.email == null) {
        AppLoader.hide();
        return AppMessage.error("No user is currently logged in");
      }

      // Re-authenticate user
      final cred = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );
      await user.reauthenticateWithCredential(cred);

      // Update password
      await user.updatePassword(newPassword);
      AppLoader.hide();
      AppMessage.success("Password updated successfully!");
    } on FirebaseAuthException catch (e) {
      AppLoader.hide();
      String message = "Failed to update password";
      if (e.code == 'wrong-password') message = "Current password is incorrect";
      if (e.code == 'weak-password') message = "New password is too weak";
      AppMessage.error(message);
    } catch (e) {
      AppLoader.hide();
      AppMessage.error("Unexpected error occurred");
      if (kDebugMode) print(e);
    } finally {
      AppLoader.hide();
    }
  }

  /// DELETE ACCOUNT
  Future<void> deleteAccount()
  async {
    try {
      AppLoader.show(message: "Deleting account...");
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        AppLoader.hide();
        return AppMessage.error("No user is currently logged in");
      }

      await user.delete();
      AppLoader.hide();
      AppMessage.success("Account deleted successfully!");
      Get.offAll(() => LoginScreen());
    } on FirebaseAuthException catch (e) {
      AppLoader.hide();
      String message = "Failed to delete account";
      if (e.code == 'requires-recent-login') {
        message =
        "You need to re-login before deleting your account for security reasons";
      }
      AppMessage.error(message);
    } catch (e) {
      AppLoader.hide();
      AppMessage.error("Unexpected error occurred");
      if (kDebugMode) print(e);
    } finally {
      AppLoader.hide();
    }
  }



  /// CLEANUP
  @override
  void onClose() {
    emailCheckTimer?.cancel();
    super.onClose();
  }
}
