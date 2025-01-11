import 'package:diigoo/theme/theme.dart';
import 'package:flutter/material.dart';

class GenderSelectionWidget extends StatefulWidget {
  const GenderSelectionWidget({super.key});

  @override
  _GenderSelectionWidgetState createState() => _GenderSelectionWidgetState();
}

class _GenderSelectionWidgetState extends State<GenderSelectionWidget> {
  String _selectedGender = "";

  final List<Map<String, String>> genderOptions = [
    {"label": "Male", "image": "assets/images/male.png"},
    {"label": "Female", "image": "assets/images/female.png"},
    {"label": "Others", "image": "assets/images/male.png"},
  ];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Select Your Gender",
          style: TextStyle(
            fontSize: screenWidth * 0.06, // Responsive font size
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: screenHeight * 0.02), // Responsive spacing

        // Gender Selection Row
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: genderOptions.map((gender) {
            bool isSelected = _selectedGender == gender["label"];
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedGender = gender["label"]!;
                });
              },
              child: Container(
                width: screenWidth * 0.25, // Responsive width
                height: screenHeight * 0.13, // Responsive height
                padding: EdgeInsets.all(screenWidth * 0.025),
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                decoration: BoxDecoration(
                  color: const Color(0xFFE4E4E4),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primaryLight
                        : Colors.transparent,
                    width: isSelected ? 2 : 0,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    if (isSelected)
                      BoxShadow(
                        color: AppColors.primaryLight.withOpacity(0.4),
                        blurRadius: 5,
                        spreadRadius: 2,
                      ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Gender Image
                    Container(
                      width: screenWidth * 0.14, // Responsive size
                      height: screenWidth * 0.14,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 2,
                        ),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          gender["image"]!,
                          width: screenWidth * 0.15,
                          height: screenWidth * 0.15,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Radio Button
                        Container(
                          width: screenWidth * 0.04,
                          height: screenWidth * 0.04,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: const Color.fromARGB(255, 209, 209, 209),
                                width: 2),
                            color: isSelected
                                ? AppColors.primaryLight
                                : Colors.white,
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.01),

                        Text(
                          gender["label"]!,
                          style: TextStyle(
                            fontSize:
                                screenWidth * 0.04, // Responsive font size
                            fontWeight: FontWeight.bold,
                            color: isSelected
                                ? AppColors.primaryLight
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
