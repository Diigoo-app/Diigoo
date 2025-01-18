import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:diigoo/screens/AuthScreen/pages/profile_wallet.dart';
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
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  void _showImagePickerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromRGBO(227, 227, 227, 1.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: [
                    Image.asset('assets/images/gallery_icon.png'),
                    const SizedBox(height: 10),
                    const SizedBox(height: 20),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.camera);
                  },
                  icon: const Icon(Icons.camera_alt, color: Colors.black),
                  label: const Text(
                    "Take Photo",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.gallery);
                  },
                  icon: const Icon(Icons.photo_library, color: Colors.black),
                  label: const Text(
                    "Choose From Gallery",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight *
                        0.3, // Ensures enough space for the stack
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: screenHeight * 0.25,
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
                          top: screenHeight * 0.04,
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
                          top: screenHeight * 0.06,
                          left: screenWidth * 0.35,
                          child: Image.asset('assets/images/Group.png',
                              width: screenWidth * 0.3),
                        ),
                        Positioned(
                          top: screenHeight * 0.116,
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
                                  CircleAvatar(
                                    radius: screenWidth * 0.142,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: screenWidth * 0.13,
                                      backgroundColor: Colors.grey[300],
                                      backgroundImage: _selectedImage != null
                                          ? FileImage(_selectedImage!)
                                          : null,
                                      child: _selectedImage == null
                                          ? Icon(
                                              Icons.person,
                                              size: screenWidth * 0.12,
                                              color: Colors.grey[700],
                                            )
                                          : null,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: _showImagePickerDialog,
                                      child: CircleAvatar(
                                        radius: screenWidth * 0.05,
                                        backgroundColor: Colors.grey[400],
                                        child: Icon(
                                          Icons.add,
                                          size: screenWidth * 0.05,
                                          color: Colors.white,
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
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildTextField(
                            "Full name", "Enter your name", fullNameController),
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
    );
  }
}
