import 'package:flutter/material.dart';

Widget customTextFormField(
    {required String hintText,
    Function(String)? onChanged,
    bool obsecureText = false}) {
  return TextFormField(
    obscureText: obsecureText!,
    validator: (data) {
      if (data!.isEmpty) {
        return "Fill the Field as it is required";
      }
    },
    onChanged: onChanged,
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(
        color: Colors.white,
      ),
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Colors.white,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Colors.white,
        ),
      ),
    ),
    style: const TextStyle(
      color: Colors.white,
    ),
  );
}
