import 'package:diigoo/routes/routes.dart';
import 'package:flutter/material.dart';

class BallDropScreen extends StatefulWidget {
  const BallDropScreen({super.key});

  @override
  _BallDropScreenState createState() => _BallDropScreenState();
}

class _BallDropScreenState extends State<BallDropScreen>
    with TickerProviderStateMixin {
  late AnimationController _dropController;
  late Animation<double> _dropAnimation;
  late AnimationController _expandController;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();

    // Ball Drop Animation Controller
    _dropController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Drop Animation with bouncing effect
    _dropAnimation = Tween<double>(begin: 0, end: 0.5).animate(
      CurvedAnimation(parent: _dropController, curve: Curves.bounceOut),
    );

    // Ball Expansion Animation Controller
    _expandController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _expandAnimation = Tween<double>(begin: 100, end: 2000).animate(
      CurvedAnimation(parent: _expandController, curve: Curves.easeOut),
    );

    _dropController.forward().then((_) {
      _expandController.forward().then((_) {
        Navigator.pushNamed(context, Routes.logo);
      });
    });
  }

  @override
  void dispose() {
    _dropController.dispose();
    _expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenHeight = constraints.maxHeight;
          double screenWidth = constraints.maxWidth;

          return AnimatedBuilder(
            animation: Listenable.merge([_dropAnimation, _expandAnimation]),
            builder: (context, child) {
              return Stack(
                children: [
                  Positioned(
                    left: screenWidth / 2 - _expandAnimation.value / 2,
                    top: _dropAnimation.value * screenHeight -
                        _expandAnimation.value / 2,
                    child: Container(
                      width: _expandAnimation.value,
                      height: _expandAnimation.value,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFFA072FF),
                            Color(0xFF5121FF),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
