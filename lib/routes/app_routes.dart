import 'package:flutter/material.dart';
import 'package:autiverse/views/welcomepage/welcome_page.dart';
import 'package:autiverse/views/loginpage/login_page.dart';
import 'package:autiverse/views/signuppage/signup_page.dart';
import 'package:autiverse/views/homepage/home_page.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> get routes {
    return {
      '/': (context) => const WelcomePage(),
      '/login': (context) => const LoginPage(),
      '/signup': (context) => const SignupPage(),
      '/home': (context) => const HomePage(),
    };
  }
}
