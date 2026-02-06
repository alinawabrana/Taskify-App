import 'package:flutter/material.dart';

class PrimaryTextFormField extends StatelessWidget {
  const PrimaryTextFormField({
    super.key,
    required this.label,
    required this.controller,
    this.enabled = true,
    this.fontColor,
    this.validator,
    this.focusNode,
    this.maxLines = 1,
  });

  final String label;
  final TextEditingController controller;
  final bool enabled;
  final Color? fontColor;
  final FormFieldValidator? validator;
  final FocusNode? focusNode;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: fontColor ?? Colors.white),
      enabled: enabled,
      focusNode: focusNode,
      validator: validator,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white),
        enabledBorder: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(width: 1, color: Colors.grey),
        ),
        focusedBorder: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(width: 1, color: Colors.grey),
        ),
        floatingLabelStyle: const TextStyle().copyWith(
          color: Colors.white.withOpacity(0.8),
        ),
        disabledBorder: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(width: 1, color: Colors.white12),
        ),
      ),
    );
  }
}
