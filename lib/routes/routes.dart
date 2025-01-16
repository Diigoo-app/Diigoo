import 'package:diigoo/screens/AuthScreen/pages/OtpVerificationScreen.dart';
import 'package:diigoo/screens/AuthScreen/pages/PhotoVerificationConfirm.dart';
import 'package:diigoo/screens/AuthScreen/pages/SignUpScreen.dart';
import 'package:diigoo/screens/AuthScreen/pages/SignupDetailsScreen.dart';
import 'package:diigoo/screens/AuthScreen/pages/SignupHashtagPage.dart';
import 'package:diigoo/screens/AuthScreen/pages/face_scanning_screen.dart';
import 'package:diigoo/screens/AuthScreen/pages/photo_verification_screen.dart';
import 'package:diigoo/screens/AuthScreen/pages/profile_edit.dart';
import 'package:diigoo/screens/AuthScreen/pages/profile_wallet.dart';
import 'package:diigoo/screens/SplashScreen/pages/IntroScreen.dart';
import 'package:flutter/material.dart';
import 'package:diigoo/screens/SplashScreen/pages/SplashScreen.dart';
import 'package:diigoo/screens/SplashScreen/pages/LogoScreen.dart';

class Routes {
  static const String splash = '/';
  static const String logo = '/logo';
  static const String home = '/home';
  static const String signUp = '/signUp';
  static const String otpVerification = '/otpVerification';
  static const String signUpDetails = '/signUpDetails';
  static const String photoVerification = '/photoVerification';
  static const String faceScanning = '/faceScanning';
  static const String profileEdit = '/profileEdit';
  static const String profileWallet = '/profileWallet';
  static const String signupHashtagPage = '/signupHashtagPage';
  static const String photoVerificationConfirm = '/photoVerificationConfirm';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return _fadeRoute(const BallDropScreen(), settings);
      case logo:
        return _fadeRoute(const LogoScreen(), settings);
      case home:
        return _slideRoute(const IntroScreen(), settings);
      case signUp:
        return _slideRoute(const SignUpScreen(), settings);
      case otpVerification:
        return _defaultRoute(const OtpVerificationScreen(), settings);
      case signUpDetails:
        return _defaultRoute(const SignupDetailsScreen(), settings);
      case photoVerification:
        return _defaultRoute(const PhotoVerificationScreen(), settings);
      case faceScanning:
        return _defaultRoute(const FaceScanningScreen(), settings);
      // ignore: constant_pattern_never_matches_value_type
      case profileEdit:
        return _defaultRoute(const ProfileEdit(), settings);
      case profileWallet:
        final args = settings.arguments as Map<String, dynamic>?;
        return _defaultRoute(
          ProfileWallet(
            userName: args?['userName'] ?? '',
            fullName: args?['fullName'] ?? '',
            profileImage: args?['profileImage'],
          ),
          settings,
        );
      case signupHashtagPage:
        return _defaultRoute(const SignupHashtagPage(), settings);
      case photoVerificationConfirm:
        final args = settings.arguments as Map<String, dynamic>?;
        return _defaultRoute(
          PhotoVerificationConfirm(imagePath: args?['imagePath'] ?? ''),
          settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }

  static PageRouteBuilder _fadeRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      transitionDuration: const Duration(milliseconds: 700),
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  static PageRouteBuilder _slideRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      transitionDuration: const Duration(milliseconds: 700),
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        var begin = const Offset(0.0, 1.0); // Start from bottom
        var end = Offset.zero;
        var tween = Tween(begin: begin, end: end)
            .chain(CurveTween(curve: Curves.easeOut));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }

  static MaterialPageRoute _defaultRoute(Widget page, RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => page,
    );
  }
}
