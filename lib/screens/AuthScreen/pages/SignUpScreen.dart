import 'dart:async';
import 'package:diigoo/screens/AuthScreen/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:diigoo/widgets/gradient_button.dart';
import 'package:diigoo/routes/routes.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _numberController = TextEditingController();
  final List<String> images = [
    'assets/images/signUp-1.png',
    'assets/images/signUp-2.png',
    'assets/images/signUp-3.png',
  ];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (mounted) {
        setState(() {
          currentIndex = (currentIndex + 1) % images.length;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.05), // Responsive spacing

            // Animated Image
            Center(
              child: AnimatedSwitcher(
                duration: const Duration(seconds: 1),
                child: Image.asset(
                  images[currentIndex],
                  key: ValueKey<String>(images[currentIndex]),
                  width: screenWidth * 0.68, // Responsive image width
                  fit: BoxFit.contain,
                ),
              ),
            ),

            Expanded(
              child: DraggableScrollableSheet(
                initialChildSize: 0.95,
                minChildSize: 0.95,
                maxChildSize: 0.95,
                builder: (context, scrollController) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05, // Responsive padding
                      vertical: screenHeight * 0.03,
                    ),
                    decoration: const BoxDecoration(
                      color: Color(0xFFF6F6F6),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          spreadRadius: 2,
                          offset: Offset(0, -1),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Create An Account",
                            style: TextStyle(
                              fontSize:
                                  screenWidth * 0.07, // Responsive font size
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),

                          SizedBox(height: screenHeight * 0.03),

                          // Phone Number Label
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Phone Number",
                              style: TextStyle(
                                fontSize: screenWidth * 0.045,
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

                          SizedBox(height: screenHeight * 0.04),

                          // Send OTP Button
                          SizedBox(
                            width: screenWidth * 0.9, // Responsive button width
                            child: GradientButtonWidget(
                              text: "Send OTP",
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, Routes.otpVerification);
                              },
                            ),
                          ),

                          SizedBox(height: screenHeight * 0.03),

                          // Login Option
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already Have An Account? ",
                                style: TextStyle(fontSize: screenWidth * 0.04),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, Routes.home);
                                },
                                child: Text(
                                  "Log In",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenWidth * 0.04,
                                    color: const Color(0xFF5121FF),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: screenHeight * 0.02),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
