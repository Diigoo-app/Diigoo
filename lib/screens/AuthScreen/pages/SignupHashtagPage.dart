import 'package:diigoo/routes/routes.dart';
import 'package:diigoo/screens/AuthScreen/widgets/HashtagChip.dart';
import 'package:diigoo/widgets/gradient_button.dart';
import 'package:diigoo/theme/theme.dart';
import 'package:flutter/material.dart';

class SignupHashtagPage extends StatefulWidget {
  const SignupHashtagPage({super.key});

  @override
  _SignupHashtagPageState createState() => _SignupHashtagPageState();
}

class _SignupHashtagPageState extends State<SignupHashtagPage> {
  final List<String> predefinedHashtags = [
    "Love",
    "Education",
    "Music",
    "Design",
    "Art",
    "Dance",
    "Cricket",
    "Fashion",
    "Food",
    "Moon",
    "Sky"
  ];
  final List<String> selectedHashtags = [];

  void _toggleHashtag(String hashtag) {
    setState(() {
      if (selectedHashtags.contains(hashtag)) {
        selectedHashtags.remove(hashtag);
      } else {
        selectedHashtags.add(hashtag);
      }
    });
  }

  void _removeHashtag(String hashtag) {
    setState(() {
      selectedHashtags.remove(hashtag);
    });
  }

  void _showAddHashtagDialog() {
    TextEditingController hashtagController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: const Text("Add Hashtag"),
          content: TextField(
            controller: hashtagController,
            decoration: const InputDecoration(hintText: "Enter hashtag"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (hashtagController.text.isNotEmpty) {
                  setState(() {
                    selectedHashtags.add(hashtagController.text.trim());
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text("Add"),
            ),
          ],
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
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.02),

              // Title
              const Text(
                "Add five or more hashtags based\non your interests.",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: screenHeight * 0.02),

              // Predefined Hashtags
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: predefinedHashtags
                    .map((hashtag) => SelectableHashtagChip(
                          label: hashtag,
                          isSelected: selectedHashtags.contains(hashtag),
                          onTap: () => _toggleHashtag(hashtag),
                        ))
                    .toList(),
              ),

              // "Add More" Button (Outlined)
              SizedBox(height: screenHeight * 0.02),
              Align(
                alignment: Alignment.centerLeft,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF5121FF), width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: _showAddHashtagDialog,
                  child: const Text(
                    "Add More",
                    style: TextStyle(color: Color(0xFF5121FF)),
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.03),

              if (selectedHashtags.isNotEmpty)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: HashtagList(
                        hashtags: selectedHashtags,
                        onRemove: _removeHashtag,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.04), // Spacing

                    // Floating "+" Button with Gradient Background
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: AppColors.primaryGradient,
                      ),
                      child: FloatingActionButton(
                        onPressed: _showAddHashtagDialog,
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        child: const Icon(Icons.add, color: Colors.white),
                      ),
                    ),
                  ],
                ),

              const Spacer(),

              SizedBox(height: screenHeight * 0.03),

              // "Next" Button (Bottom Right)
              Align(
                alignment: Alignment.bottomRight,
                child: GradientButtonWidget(
                  size: const Size(150, 50),
                  text: "Next",
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.profileEdit);
                  },
                ),
              ),

              SizedBox(height: screenHeight * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
