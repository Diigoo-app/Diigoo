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
            .unfocus(); // Hide keyboard when the last digit is entered
      }
    }
  }

  void _handleBackspace(int index) {
    if (index > 0) {
      // Move back to the previous field
      _controllers[index - 1].clear();
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    }
  }

  @override
  Widget build(BuildContext context) {
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
            width: 50,
            height: 55,
            margin: const EdgeInsets.symmetric(horizontal: 5),
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
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
