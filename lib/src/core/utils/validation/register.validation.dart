import 'package:easy_localization/easy_localization.dart';
import 'package:chat_app/src/core/utils/validation/base/email.validation.dart';
import 'package:chat_app/src/core/utils/validation/base/password.validation.dart';

String? validateName(String? value) {
  if (value == null || value.isEmpty) {
    return tr('validation.name.required');
  }
  if (value.length < 2) {
    return tr('validation.name.min');
  }
  return null;
}

const registerValidation = {
  'email': validateEmail,
  'password': validatePassword,
  'name': validateName,
};
