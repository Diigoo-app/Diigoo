import 'dart:async';
import 'package:flutter/material.dart';
import 'package:diigoo/screens/AuthScreen/widgets/custom_otp_field.dart';
import 'package:diigoo/widgets/gradient_button.dart';
import 'package:diigoo/routes/routes.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideUpAnimation;
  bool _showImage = false;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    // Slide up animation for image
    _slideUpAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _showImage = true;
        });
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: DraggableScrollableSheet(
        initialChildSize: 0.90,
        minChildSize: 0.90,
        maxChildSize: 0.90,
        builder: (context, scrollController) {
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05, // Responsive padding
              vertical: screenHeight * 0.02,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back,
                        size: 28, color: Colors.black),
                  ),
                ),

                SizedBox(height: screenHeight * 0.009),

                // OTP Image with Animation
                SizedBox(
                  height: screenHeight * 0.2, // Adjusted image height
                  child: AnimatedOpacity(
                    opacity: _showImage ? 1.0 : 0.0,
                    duration: const Duration(seconds: 1),
                    child: SlideTransition(
                      position: _slideUpAnimation,
                      child: Image.asset(
                        'assets/images/otp.png',
                        width: screenWidth * 0.6, // Responsive image width
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.01),

                // OTP Heading
                Text(
                  "Verify OTP",
                  style: TextStyle(
                    fontSize: screenWidth * 0.07, // Responsive font size
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),

                SizedBox(height: screenHeight * 0.01),

                Text(
                  "Please enter the 6-digit code sent to your email.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenWidth * 0.04, // Responsive text size
                    color: Colors.grey,
                  ),
                ),

                SizedBox(height: screenHeight * 0.05),

                // OTP Input Fields
                const CustomOtpField(),

                SizedBox(height: screenHeight * 0.04),

                // Verify Button
                SizedBox(
                  width: screenWidth * 0.8, // Responsive button width
                  child: GradientButtonWidget(
                    text: "Verify",
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.signUpDetails);
                    },
                  ),
                ),

                SizedBox(height: screenHeight * 0.03),

                // Resend OTP Option
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Yet to receive the code? ",
                      style: TextStyle(fontSize: screenWidth * 0.04),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "Resend",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.04,
                          color: const Color(0xFF5121FF),
                        ),
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                // "Already Have An Account?" Section - Fixed at Bottom
                Padding(
                  padding: EdgeInsets.only(bottom: screenHeight * 0.03),
                  child: Row(
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
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
