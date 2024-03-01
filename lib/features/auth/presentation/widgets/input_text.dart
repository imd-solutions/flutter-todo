import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InputText extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final bool email;
  final bool password;

  const InputText({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.controller,
    this.email = false,
    this.password = false,
  });

  @override
  Widget build(context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (email && (value == null || value.isEmpty || !value.isEmail)) {
          return 'Please complete the email field';
        } else if (value == null || value.isEmpty) {
          return 'Please complete the field';
        }
        return null;
      },
      obscureText: password,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText,
        hintText: hintText,
      ),
    );
  }
}
