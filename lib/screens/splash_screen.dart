import 'package:darra5/screens/investments_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:darra5/controllers/auth_controller.dart';
import 'package:darra5/screens/intro_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());

    Future<void> navigate() async {
      await Future.delayed(const Duration(seconds: 3));
  
        if (authController.isLoggedIn()) {
          Get.offAll(() => const InvestmentListScreen());
        } else {
          Get.offAll(() => const IntroScreen());
        } 
      }
    

    // Call navigate method after build is complete
    WidgetsBinding.instance.addPostFrameCallback((_) => navigate());

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}