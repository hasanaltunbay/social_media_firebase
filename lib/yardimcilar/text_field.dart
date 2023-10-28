import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  MyTextField({required this.controller,required this.hintText,required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade900),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade900),
      ),
    fillColor: Colors.grey.shade200,
    filled: true,
    hintText: hintText,
    hintStyle: TextStyle(color: Colors.grey),
      ),
    );
  }
}
