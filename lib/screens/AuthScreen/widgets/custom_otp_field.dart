import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomOtpField extends StatefulWidget {
  const CustomOtpField({super.key});

  @override
  _CustomOtpFieldState createState() => _CustomOtpFieldState();
}

class _CustomOtpFieldState extends State<CustomOtpField> {
  final List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _handleInputChange(String value, int index) {
    if (value.isNotEmpty) {
      // Move to the next field if not the last index
      if (index < 5) {
        FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
      } else {
        _focusNodes[index]
            .unfocus(); // Hide keyboard when last digit is entered
      }
    }
  }

  void _handleBackspace(int index) {
    if (index > 0) {
      _controllers[index - 1].clear();
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(6, (index) {
        return RawKeyboardListener(
          focusNode: FocusNode(),
          onKey: (RawKeyEvent event) {
            if (event is RawKeyDownEvent &&
                event.logicalKey == LogicalKeyboardKey.backspace &&
                _controllers[index].text.isEmpty) {
              _handleBackspace(index);
            }
          },
          child: Container(
            width: screenWidth * 0.12, // Scales OTP box width
            height: screenHeight * 0.07, // Scales OTP box height
            margin: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.015), // Adjusts spacing
            decoration: BoxDecoration(
              border: Border.all(color: Colors.purple),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: _controllers[index],
              focusNode: _focusNodes[index],
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              maxLength: 1,
              style: TextStyle(
                fontSize: screenWidth * 0.06, // Responsive font size
                fontWeight: FontWeight.bold,
              ),
              decoration: const InputDecoration(
                counterText: "", // Hides the character counter
                border: InputBorder.none,
              ),
              onChanged: (value) => _handleInputChange(value, index),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly, // Allow only numbers
              ],
              onTapOutside: (event) {
                FocusScope.of(context)
                    .unfocus(); // Hide keyboard on outside tap
              },
            ),
          ),
        );
      }),
    );
  }
}
