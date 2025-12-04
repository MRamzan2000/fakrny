class AppValidator {
  static String? validateName(String value) {
    if (value.trim().isEmpty) return "Please enter your name";
    return null;
  }

  static String? validateEmail(String value) {
    if (value.trim().isEmpty) return "Please enter your email";

    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value.trim())) return "Invalid email format";

    return null;
  }

  static String? validatePassword(String value) {
    if (value.trim().isEmpty) return "Please enter your password";
    if (value.trim().length < 6) return "Password must be at least 6 characters";
    return null;
  }

  static String? validateConfirmPassword(String pass, String confirm) {
    if (confirm.trim().isEmpty) return "Please confirm your password";
    if (pass.trim() != confirm.trim()) return "Passwords do not match";
    return null;
  }

  static String? validateGender(dynamic gender) {
    if (gender == null) return "Please select your gender";
    return null;
  }

  static String? validateDob(DateTime? dob) {
    if (dob == null) return "Please select your date of birth";
    return null;
  }
}
