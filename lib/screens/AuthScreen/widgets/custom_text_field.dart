import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final String hintText;
  final IconData? suffixIcon;
  final TextInputType keyboardType;
  final TextEditingController controller;

  const CustomTextFieldWidget({
    super.key,
    required this.hintText,
    this.suffixIcon,
    this.keyboardType = TextInputType.phone,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.1),
            blurRadius: 1,
            spreadRadius: 0.2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: TextField(
        keyboardType: keyboardType,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Color.fromARGB(103, 158, 158, 158)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          filled: true,
          fillColor: Colors.white,
          suffixIcon: suffixIcon != null
              ? Icon(suffixIcon, color: const Color(0xFF5121FF))
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
