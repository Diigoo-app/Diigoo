import 'package:diigoo/screens/SplashScreen/pages/IntroScreen.dart';
import 'package:flutter/material.dart';
import 'package:diigoo/screens/SplashScreen/pages/SplashScreen.dart';
import 'package:diigoo/screens/SplashScreen/pages/LogoScreen.dart';

class Routes {
  static const String splash = '/';
  static const String logo = '/logo';
  static const String home = '/home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return _fadeRoute(const SplashScreen(), settings);
      case logo:
        return _fadeRoute(const LogoScreen(), settings);
      case home:
        return _slideRoute(const IntroScreen(), settings);
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
}
