import 'package:flutter/material.dart';
import 'package:madshop_ui_golovin/screens/splash_screen.dart';
import 'package:madshop_ui_golovin/services/cart_service.dart';
import 'package:madshop_ui_golovin/theme/colors.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartService(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MAD Shop',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.accentPurple),
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.primaryText),
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
