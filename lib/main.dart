import 'dart:convert';

import 'package:demo_users_app/bottom_navigation_barr.dart';
import 'package:demo_users_app/cm.dart';
import 'package:demo_users_app/features/auth/model/login_response_model.dart';
import 'package:demo_users_app/features/users/model/user_response.dart';
import 'package:demo_users_app/features/auth/screens/login_screen.dart';
import 'package:demo_users_app/features/auth/screens/splash_screen.dart';
import 'package:demo_users_app/helper/shared_preference_helper.dart';
import 'package:demo_users_app/utils/utils.dart';
import 'package:flutter/material.dart';

final SharedPrefsHelper sharedprefshelper = SharedPrefsHelper();
UserResponse? userData;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await sharedprefshelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(backgroundColor: AppColors.whitecolor),
        scaffoldBackgroundColor: AppColors.whitecolor
      ),
      home: SplashScreen(),
    );
  }
}
