import 'package:demo_users_app/bottom_navigation_barr.dart';
import 'package:demo_users_app/cm.dart';
import 'package:demo_users_app/features/auth/screens/login_screen.dart';
import 'package:demo_users_app/helper/shared_preference_helper.dart';
import 'package:demo_users_app/utils/utils.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    navigateFromSplash();
    super.initState();
  }

  Future<void> navigateFromSplash() async {
    final String? token = getAccessToken();
    Future.delayed(Duration(seconds: 2),() {
      if (token != null && token.isNotEmpty) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => BottomNavigationBarr()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => LoginScreen()),
        );
      }
    },);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primarycolor,
      body: Center(
        child: Text("Demo Users App",
        style: TextStyle(
          color: AppColors.whitecolor,
          fontSize: 30,
          fontFamily: Appfonts.robotobold
        ),
        ),
      ),
    );
  }
}
