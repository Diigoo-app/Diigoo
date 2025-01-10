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
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Back Button
                          SizedBox(height: screenHeight * 0.02),
                          Align(
                            alignment: Alignment.topLeft,
                            child: GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: const Icon(Icons.arrow_back,
                                  size: 28, color: Colors.black),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.04),

                          // Title
                          Text(
                            "Choose username",
                            style: TextStyle(
                              fontSize: screenWidth * 0.06,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),

                          // Description
                          Text(
                            "Lorem Ipsum Dolor Sit Amet, Consectetur Adipiscing Elit, Sed Do Eiusmod Tempor Incididunt Ut Labore",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: screenWidth * 0.04,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.03),

                          // Username Input Field
                          CustomTextFieldWidget(
                            hintText: "Eg: Rajesh_kondeti_8",
                            suffixIcon: Icons.check,
                            keyboardType: TextInputType.text,
                            controller: _usernameController,
                          ),
                          SizedBox(height: screenHeight * 0.04),

                          // Birthday Section
                          Text(
                            "When’s your b’day?",
                            style: TextStyle(
                              fontSize: screenWidth * 0.06,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),

                          Text(
                            'We’ll never share this with other users. We’re just making sure you’re old enough to use vibe!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: screenWidth * 0.04,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.03),

                          // Date Picker
                          BirthdateSelectionWidget(
                            onDateSelected: (day, month, year) {
                              log("Selected Date: $day-$month-$year");
                            },
                          ),
                          SizedBox(height: screenHeight * 0.05),

                          // Gender Selection
                          const GenderSelectionWidget(),
                          SizedBox(height: screenHeight * 0.08),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: screenHeight * 0.03,
              right: screenWidth * 0.05,
              child: GradientButtonWidget(
                size: Size(screenWidth * 0.45, screenHeight * 0.06),
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
