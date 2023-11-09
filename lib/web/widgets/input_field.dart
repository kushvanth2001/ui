import 'package:flutter/material.dart';
class InputField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final Function(String) onChanged;
  final bool obscureText;
  

  InputField({
    required this.labelText,
    required this.hintText,
    required this.onChanged,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
      ),
      obscureText: obscureText,
      onChanged: onChanged,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $labelText';
        }
        return null;
      },
    );
  }
}
