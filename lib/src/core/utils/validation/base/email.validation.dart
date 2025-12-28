import 'package:easy_localization/easy_localization.dart';

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return tr('validation.email.required');
  }
  final emailRegex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );
  if (!emailRegex.hasMatch(value)) {
    return tr('validation.email.invalid');
  }
  return null;
}
