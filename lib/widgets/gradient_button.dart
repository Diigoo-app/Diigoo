import 'package:flutter/material.dart';

class GradientButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Size size;

  const GradientButtonWidget(
      {super.key,
      required this.text,
      required this.onPressed,
      this.size = const Size(0, 0)});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size != const Size(0, 0) ? size.width : double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        onPressed: onPressed,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: const LinearGradient(
              colors: [Color(0xFFA072FF), Color(0xFF5121FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              text,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
