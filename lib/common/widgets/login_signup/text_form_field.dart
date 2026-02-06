import 'package:flutter/material.dart';

import '../../../utils/constants/text_strings.dart';

class LoginSignupTextFormField extends StatelessWidget {
  const LoginSignupTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    this.suffixIcon,
  });

  final TextEditingController controller;
  final String labelText;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.white),
        floatingLabelStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(width: 1, color: Colors.white),
        ),
        suffixIcon: suffixIcon,
      ),
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
    );
  }
}
