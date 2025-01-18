import 'dart:io';
import 'package:diigoo/routes/routes.dart';
import 'package:diigoo/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:diigoo/widgets/gradient_button.dart';

class PhotoVerificationConfirm extends StatelessWidget {
  final String imagePath;

  const PhotoVerificationConfirm({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Top Section
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenSize.width * 0.05,
                  vertical: screenSize.height * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Back Button
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back,
                          size: 28, color: Colors.black),
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.05),

                  // Profile Picture with Tick
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 80,
                        backgroundImage: imagePath.isNotEmpty
                            ? FileImage(File(imagePath))
                            : const AssetImage(
                                    'assets/images/photo_verification.png')
                                as ImageProvider,
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.white,
                          child: Image.asset(
                            'assets/images/tick.png',
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenSize.height * 0.04),

                  // Percentage Text
                  const Text(
                    "100%",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 28, 28, 28),
                    ),
                  ),

                  SizedBox(height: screenSize.height * 0.01),

                  // Verifying Text
                  const Text(
                    "Verifying Your Face",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 28, 28, 28),
                    ),
                  ),

                  SizedBox(height: screenSize.height * 0.00),

                  // Rescan Button
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/rescan.png',
                          width: screenSize.width * 0.3,
                          height: screenSize.width * 0.3,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenSize.width * 0.05,
                  vertical: screenSize.height * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Skip Button
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Skip",
                      style: TextStyle(
                        color: const Color(0xFF411ACC),
                        fontSize: screenSize.width * 0.045,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // Next Button
                  GradientButtonWidget(
                    size: const Size(150, 50),
                    text: "Next",
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.profileEdit);
                    },
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
