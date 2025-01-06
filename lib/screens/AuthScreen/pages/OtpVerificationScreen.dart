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
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: DraggableScrollableSheet(
        initialChildSize: 0.90,
        minChildSize: 0.90,
        maxChildSize: 0.90,
        builder: (context, scrollController) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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

                SizedBox(
                  height: 200,
                  child: AnimatedOpacity(
                    opacity: _showImage ? 1.0 : 0.0,
                    duration: const Duration(seconds: 1),
                    child: SlideTransition(
                      position: _slideUpAnimation,
                      child: Image.asset(
                        'assets/images/otp.png',
                        width: 250,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // OTP Heading
                const Text(
                  "Verify OTP",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Please enter the 6-digit code sent to your email.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 40),

                // OTP Input Fields
                const CustomOtpField(),

                const SizedBox(height: 40),

                // Verify Button
                GradientButtonWidget(
                  text: "Verify",
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.signUpDetails);
                  },
                ),

                // Resend OTP Option
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Yet to receive the code? "),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        "Resend",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF5121FF)),
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already Have An Account? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.home);
                        },
                        child: const Text(
                          "Log In",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF5121FF)),
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
