import 'dart:async';
import 'package:flutter/material.dart';
import 'package:madshop_ui_golovin/screens/home_screen.dart';
import 'package:madshop_ui_golovin/theme/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.inputFill,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundColor: AppColors.inputFill,
              child: Image.asset(
                'assets/images/madshop_logo.png',
                width: 120,
                height: 120,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
