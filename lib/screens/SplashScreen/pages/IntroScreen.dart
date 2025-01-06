import 'package:flutter/material.dart';
import 'package:diigoo/widgets/gradient_button.dart';
import 'package:diigoo/widgets/outlined_button.dart';
import 'package:diigoo/routes/routes.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 40),

            // Welcome Text
            const Text(
              "Hey Welcome!",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5121FF),
              ),
            ),
            const SizedBox(height: 10),

            const Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 50),

            GradientButtonWidget(
              text: "Create An Account",
              onPressed: () {
                Navigator.pushNamed(context, Routes.signUp);
              },
            ),
            const SizedBox(height: 15),

            OutlinedButtonWidget(
              text: "I Already Have An Account",
              onPressed: () {
                Navigator.pushNamed(context, Routes.logo);
              },
            ),
          ],
        ),
      ),
    );
  }
}
