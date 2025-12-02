String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password is required';
  }
  if (value.length < 8) {
    return 'Password must be at least 8 characters long';
  }
  final hasUppercase = RegExp(r'[A-Z]').hasMatch(value);
  final hasLowercase = RegExp(r'[a-z]').hasMatch(value);
  final hasDigit = RegExp(r'\d').hasMatch(value);
  final hasSpecialChar = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value);

  if (!hasUppercase) {
    return 'Password must contain at least one uppercase letter';
  }
  if (!hasLowercase) {
    return 'Password must contain at least one lowercase letter';
  }
  if (!hasDigit) {
    return 'Password must contain at least one digit';
  }
  if (!hasSpecialChar) {
    return 'Password must contain at least one special character';
  }
  return null;
}
