import 'package:diigoo/routes/routes.dart';
import 'package:diigoo/screens/AuthScreen/pages/profile_wallet.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:diigoo/screens/AuthScreen/widgets/profile_input_fields.dart';
import 'package:diigoo/widgets/gradient_button.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  String selectedGender = "Female";

  File? _selectedImage;

  void _showImagePickerDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.purple),
                title: const Text("Take Photo"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.purple),
                title: const Text("Choose from Gallery"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // Background Image
                        Container(
                          height: screenHeight * 0.25, // 32% of screen height
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                            image: DecorationImage(
                              image: AssetImage('assets/images/Rectangle.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // Back Button
                        Positioned(
                          top: screenHeight * 0.02, // 5% from top
                          left: screenWidth * 0.02,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back,
                                color: Colors.white),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        Positioned(
                          top: screenHeight * 0.03, // Adjusted dynamically
                          left: screenWidth * 0.35,
                          child: Image.asset('assets/images/Group.png',
                              width: screenWidth * 0.3),
                        ),
                        Positioned(
                          top: screenHeight * 0.1,
                          left: 0,
                          right: 0,
                          child: Column(
                            children: [
                              Text.rich(
                                TextSpan(
                                  text: "We love a great looking profile,\n",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: screenWidth * 0.04,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "Let's make one!",
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.05,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: screenHeight * 0.18,
                          left: 0,
                          right: 0,
                          child: Column(
                            children: [
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  // Profile Picture
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 10,
                                          spreadRadius: 2,
                                        ),
                                      ],
                                    ),
                                    child: CircleAvatar(
                                      radius: screenWidth * 0.13,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: screenWidth * 0.12,
                                        backgroundImage: _selectedImage != null
                                            ? FileImage(_selectedImage!)
                                                as ImageProvider
                                            : const AssetImage(
                                                'assets/images/Profile.png'),
                                      ),
                                    ),
                                  ),

                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: _showImagePickerDialog,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                          border:
                                              Border.all(color: Colors.white),
                                        ),
                                        child: CircleAvatar(
                                          radius: screenWidth * 0.05,
                                          backgroundColor: const Color.fromARGB(
                                              255, 220, 218, 218),
                                          child: Icon(Icons.add,
                                              color: Colors.grey,
                                              size: screenWidth * 0.05),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.06),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildTextField("Full name", "Enter your name",
                              fullNameController),
                          const SizedBox(height: 10),
                          buildTextField("User name", "Enter your username",
                              userNameController),
                          const SizedBox(height: 10),
                          buildDropdownField("Gender", selectedGender, (value) {
                            setState(() {
                              selectedGender = value!;
                            });
                          }),
                          const SizedBox(height: 10),
                          buildDateField(
                              "Date of Birth", dateController, context),
                          const SizedBox(height: 10),
                          buildTextField("Mobile number", "Enter mobile number",
                              mobileNumberController),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                  ],
                ),
              ),
            ),

            // Buttons fixed at bottom
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenHeight * 0.02,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Skip",
                      style: TextStyle(
                        color: const Color(0xFF411ACC),
                        fontSize: screenWidth * 0.045,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  GradientButtonWidget(
                    size: Size(screenWidth * 0.4, screenHeight * 0.06),
                    text: "Create Wallet",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileWallet(
                            userName: userNameController.text,
                            fullName: fullNameController.text,
                            profileImage: _selectedImage,
                          ),
                        ),
                      );
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
