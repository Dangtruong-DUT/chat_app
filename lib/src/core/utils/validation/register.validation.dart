import 'package:chat_app/src/core/utils/validation/base/email.validation.dart';
import 'package:chat_app/src/core/utils/validation/base/password.validation.dart';

String? validateName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Name is required';
  }
  if (value.length < 2) {
    return 'Name must be at least 2 characters long';
  }
  return null;
}

const registerValidation = {
  'email': validateEmail,
  'password': validatePassword,
  'name': validateName,
};
