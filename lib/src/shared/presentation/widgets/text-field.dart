import 'package:flutter/material.dart';

class TTextField extends StatelessWidget {
  final String? hintText;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  const TTextField({
    super.key,
    this.hintText = 'Enter value',
    this.textInputType = TextInputType.text,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPasswordField(),
      keyboardType: textInputType,
      onChanged: (value) {
        if (!isNumberField()) return;

        final sanitizedValue = value.replaceAll(RegExp('[^0-9]'), '');
        if (sanitizedValue == value) return;
        controller?.text = sanitizedValue;
      },
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.outline,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      ),
    );
  }

  bool isPasswordField() {
    return textInputType == TextInputType.visiblePassword;
  }

  bool isNumberField() {
    return textInputType == TextInputType.number;
  }
}
