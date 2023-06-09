import 'package:flutter/material.dart';

class MyTextField extends TextField {
  MyTextField(
      {super.key,
      TextInputType textInputType = TextInputType.text,
      int heightSpan = 1})
      : super(
          keyboardType: textInputType,
          minLines: heightSpan,
          maxLines: heightSpan,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(5),
              gapPadding: 9,
            ),
          ),
        );
}
