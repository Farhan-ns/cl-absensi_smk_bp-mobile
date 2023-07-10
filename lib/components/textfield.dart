import 'package:flutter/material.dart';

class MyTextField extends TextField {
  MyTextField({
    super.key,
    TextInputType textInputType = TextInputType.text,
    required TextEditingController controller,
    int heightSpan = 1,
    bool enabled = true,
    bool obscureText = false,
  }) : super(
          keyboardType: textInputType,
          minLines: heightSpan,
          maxLines: heightSpan,
          controller: controller,
          enabled: enabled,
          obscureText: obscureText,
          decoration: InputDecoration(
            isDense: true,
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(5),
              gapPadding: 9,
            ),
          ),
        );
}
