import 'dart:convert';
import 'package:demo_users_app/bottom_navigation_barr.dart';
import 'package:demo_users_app/cm.dart';
import 'package:demo_users_app/helper/shared_preference_helper.dart';
import 'package:demo_users_app/http/internet_bloc/internet_bloc.dart';
import 'package:demo_users_app/http/internet_bloc/internet_state.dart';
import 'package:demo_users_app/screens/auth/splash_screen.dart';
import 'package:demo_users_app/screens/users/model/user_response.dart';
import 'package:demo_users_app/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final SharedPrefsHelper sharedprefshelper = SharedPrefsHelper();
UserResponse? userData;
final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sharedprefshelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final InternetBloc internetBloc = InternetBloc();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetBloc, InternetState>(
      bloc: internetBloc,
      listener: (context, state) {
        if (state.internetstatus == InternetStatus.connected) {
          Cm.showSnackBar(
            navigatorKey.currentContext!,
            message: 'connected',
            bg: AppColors.greencolor,
          );
        }
        if (state.internetstatus == InternetStatus.disconnected) {
          Cm.showSnackBar(
            navigatorKey.currentContext!,
            message: 'disconnected',
            bg: AppColors.redcolor,
          );
        }
      },
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: AppLabels.demo_users_app,
        theme: ThemeData(
          appBarTheme: AppBarTheme(backgroundColor: AppColors.whitecolor),
          scaffoldBackgroundColor: AppColors.whitecolor,
          useMaterial3: true,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
