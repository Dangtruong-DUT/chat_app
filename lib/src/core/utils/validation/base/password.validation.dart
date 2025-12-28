import 'package:easy_localization/easy_localization.dart';

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return tr('validation.password.required');
  }
  if (value.length < 8) {
    return tr('validation.password.min');
  }
  return null;
}
