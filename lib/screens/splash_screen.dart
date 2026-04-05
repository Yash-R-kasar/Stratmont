import 'package:flutter/material.dart';
import 'select_categories_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        showOnboardingDialog();
      }
    });
  }

  void showOnboardingDialog() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SelectCategoriesScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFF5FB),
      body: Center(
        child: ClipOval(
          child: Image.asset(
            'assets/images/stratmont.jpeg',
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
