import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TTextField extends StatelessWidget {
  final String? hintText;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  const TTextField({
    super.key,
    this.hintText,
    this.textInputType = TextInputType.text,
    this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      controller: controller,
      obscureText: _isPasswordField(),
      keyboardType: textInputType,
      validator: validator,
      onChanged: (value) {
        if (!_isNumberField()) return;

        final sanitizedValue = value.replaceAll(RegExp('[^0-9]'), '');
        if (sanitizedValue == value) return;
        controller?.text = sanitizedValue;
      },
      decoration: InputDecoration(
        hintText: hintText ?? tr('form.enterValue'),
        hintStyle: TextStyle(
          color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: theme.colorScheme.outline, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: theme.colorScheme.error, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: theme.colorScheme.error, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 14,
        ),
        fillColor: theme.colorScheme.surface,
        filled: true,
      ),
    );
  }

  bool _isPasswordField() {
    return textInputType == TextInputType.visiblePassword;
  }

  bool _isNumberField() {
    return textInputType == TextInputType.number;
  }
}
