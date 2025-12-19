import 'dart:developer';
import 'package:demo_users_app/bottom_navigation_barr.dart';
import 'package:demo_users_app/cm.dart';
import 'package:demo_users_app/extension.dart';
import 'package:demo_users_app/main.dart';
import 'package:demo_users_app/screens/auth/onboarding_screen.dart';
import 'package:demo_users_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../users/model/user_response.dart';

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
    final String? token = await getAccessToken();
    userData = Hive.box<UserResponse>(HiveLocalStorageBox.userBox).get(HiveLocalStorageKeys.userData);
    Future.delayed(Duration(seconds: 2), () {
      if (token.isNotNullOrEmpty()) {
        log("---------- Token ---------- ${token}");
        callNextScreenAndClearStack(context, BottomNavigationBarr());
      } else {
        callNextScreenAndClearStack(context, OnboardingScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primarycolor,
      body: Center(
        child: Text(
          AppLabels.demo_users_app,
          style: TextStyle(
            color: AppColors.whitecolor,
            fontSize: AppFontSizes.display,
            fontFamily: Appfonts.robotobold,
          ),
        ),
      ),
    );
  }
}
