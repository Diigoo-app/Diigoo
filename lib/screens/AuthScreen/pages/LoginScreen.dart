import 'package:diigoo/routes/routes.dart';
import 'package:diigoo/screens/AuthScreen/widgets/custom_text_field.dart';
import 'package:diigoo/widgets/gradient_button.dart';

import 'package:flutter/material.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final TextEditingController _numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.height;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20, top: 100),
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
              "You Have An Account",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 42),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Phone Number",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),

            SizedBox(height: screenHeight * 0.02),

            CustomTextFieldWidget(
              hintText: "Phone Number",
              suffixIcon: Icons.arrow_forward,
              keyboardType: TextInputType.phone,
              controller: _numberController,
            ),

            SizedBox(height: screenHeight * 0.06),

            SizedBox(
              width: screenWidth * 0.9,
              child: GradientButtonWidget(
                text: "Send OTP",
                onPressed: () {
                  Navigator.pushNamed(context, Routes.otpLogin);
                },
              ),
            ),

            const Spacer(),

            Padding(
              padding: EdgeInsets.only(bottom: screenHeight * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't Have An Account? ",
                    style: TextStyle(fontSize: 15),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.signUp);
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: const Color(0xFF5121FF),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
