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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Select Your Gender",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),

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
                width: 100,
                height: 120,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(horizontal: 10),
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
                      width: 55,
                      height: 55,
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
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Radio Button
                        Container(
                          width: 16,
                          height: 16,
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
                        const SizedBox(width: 5),

                        Text(
                          gender["label"]!,
                          style: TextStyle(
                            fontSize: 14,
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
