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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Center(
              child: AnimatedSwitcher(
                duration: const Duration(seconds: 1),
                child: Image.asset(
                  images[currentIndex],
                  key: ValueKey<String>(images[currentIndex]),
                  width: 280,
                  // height: 200,
                ),
              ),
            ),
            Flexible(
              child: DraggableScrollableSheet(
                initialChildSize: 0.95,
                minChildSize: 0.95,
                maxChildSize: 0.95,
                builder: (context, scrollController) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 30),
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
                          const Text(
                            "Create An Account",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 25),

                          // Phone Number Label
                          const Align(
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
                          const SizedBox(height: 25),

                          CustomTextFieldWidget(
                            hintText: "Phone Number",
                            suffixIcon: Icons.arrow_forward,
                            keyboardType: TextInputType.phone,
                            controller: _numberController,
                          ),

                          const SizedBox(height: 30),

                          // Send OTP Button
                          GradientButtonWidget(
                            text: "Send OTP",
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, Routes.otpVerification);
                            },
                          ),

                          // Login Option
                          const SizedBox(height: 20),
                          Row(
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
                          const SizedBox(height: 15),
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
