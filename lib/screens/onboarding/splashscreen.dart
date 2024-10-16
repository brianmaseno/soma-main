import 'package:flutter/material.dart';
import 'dart:async';

import 'package:system_auth/screens/authenticate/log_in.dart';
import 'package:system_auth/screens/onboarding/info/on.dart';
import 'package:system_auth/screens/onboarding/onboarding_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => OnboardingScreen11()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFDF7F2),
      body: Center(
        child: Container(
          height: 300,
          width: 300,
          child: Center(
            child: Image.asset('assets/soma2.png'),
          ),
        ),
      ),
    );
  }
}
