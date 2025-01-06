import 'dart:developer';
import 'package:diigoo/routes/routes.dart';
import 'package:diigoo/screens/AuthScreen/widgets/custom_text_field.dart';
import 'package:diigoo/screens/AuthScreen/widgets/date_selection_widget.dart';
import 'package:diigoo/screens/AuthScreen/widgets/gender_selection_widget.dart';
import 'package:flutter/material.dart';
import 'package:diigoo/widgets/gradient_button.dart';

class SignupDetailsScreen extends StatefulWidget {
  const SignupDetailsScreen({super.key});

  @override
  _SignupDetailsScreenState createState() => _SignupDetailsScreenState();
}

class _SignupDetailsScreenState extends State<SignupDetailsScreen> {
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size; // Get device size

    return Scaffold(
      backgroundColor: Colors.white, // Background color
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
              child: SingleChildScrollView(
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
                      "Choose username",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: screenSize.height * 0.02),

                    // Description
                    const Text(
                      "Lorem Ipsum Dolor Sit Amet, Consectetur Adipiscing Elit, Sed Do Eiusmod Tempor Incididunt Ut Labore",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    SizedBox(height: screenSize.height * 0.03),

                    // Username Input Field
                    CustomTextFieldWidget(
                      hintText: "Eg: Rajesh_kondeti_8",
                      suffixIcon: Icons.check,
                      keyboardType: TextInputType.text,
                      controller: _usernameController,
                    ),
                    SizedBox(height: screenSize.height * 0.04),

                    // Birthday Section
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "When’s your b’day?",
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.02),
                    const Text(
                      'We’ll never share this with other users. We’re just making sure you’re old enough to use vibe!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    SizedBox(height: screenSize.height * 0.03),

                    // Date Picker
                    BirthdateSelectionWidget(
                      onDateSelected: (day, month, year) {
                        log("Selected Date: $day-$month-$year");
                      },
                    ),
                    SizedBox(height: screenSize.height * 0.05),

                    // Gender Selection
                    const GenderSelectionWidget(),

                    SizedBox(height: screenSize.height * 0.1),
                  ],
                ),
              ),
            ),

            // Positioned Button at Bottom Right
            Positioned(
              bottom: screenSize.height * 0.001,
              right: screenSize.width * 0.05,
              child: GradientButtonWidget(
                size: const Size(150, 50),
                text: "Next",
                onPressed: () {
                  Navigator.pushNamed(context, Routes.photoVerification);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
