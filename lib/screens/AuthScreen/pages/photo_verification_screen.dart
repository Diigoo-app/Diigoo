import 'package:diigoo/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:diigoo/widgets/gradient_button.dart';

class PhotoVerificationScreen extends StatelessWidget {
  const PhotoVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Back Button
                  SizedBox(height: screenSize.height * 0.02),
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back,
                          size: 28, color: Colors.black),
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.05),

                  // Title
                  const Text(
                    "Photo Verification",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: screenSize.height * 0.03),

                  // Centered Image
                  Center(
                    child: Image.asset(
                      'assets/images/photo_verification.png',
                      width: screenSize.width * 0.6,
                      height: screenSize.width * 0.6,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.02),

                  // Subtitle
                  const Text(
                    "Verify your identity",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18, color: Color.fromARGB(255, 28, 28, 28)),
                  ),
                ],
              ),
            ),

            // Positioned Button at Bottom Right
            Positioned(
              bottom: screenSize.height * 0.05,
              right: screenSize.width * 0.05,
              child: GradientButtonWidget(
                size: const Size(150, 50),
                text: "Let's Verify",
                onPressed: () {
                  // Navigate to next screen
                  Navigator.pushNamed(context, Routes.faceScanning);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
