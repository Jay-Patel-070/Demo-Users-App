import 'package:demo_users_app/cm.dart';
import 'package:demo_users_app/helper/shared_preference_helper.dart';
import 'package:demo_users_app/http/internet_bloc/internet_bloc.dart';
import 'package:demo_users_app/http/internet_bloc/internet_state.dart';
import 'package:demo_users_app/screens/auth/splash_screen.dart';
import 'package:demo_users_app/screens/notification/notification_service.dart';
import 'package:demo_users_app/screens/theme/bloc/theme_bloc.dart';
import 'package:demo_users_app/screens/theme/bloc/theme_mode.dart';
import 'package:demo_users_app/screens/theme/bloc/theme_state.dart';
import 'package:demo_users_app/screens/users/model/user_response.dart';
import 'package:demo_users_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final SharedPrefsHelper sharedprefshelper = SharedPrefsHelper();
UserResponse? userData;
final navigatorKey = GlobalKey<NavigatorState>();
ThemeBloc themeBloc = ThemeBloc();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();
  await sharedprefshelper.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final InternetBloc internetBloc = InternetBloc();

  @override
  void initState() {
    super.initState();
    // 4. Handle navigation immediately after the initial build is complete
    WidgetsBinding.instance.addPostFrameCallback((_) {
      NotificationService().handleInitialNavigation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetBloc, InternetState>(
      bloc: internetBloc,
      listener: (context, state) {
        if (state.internetstatus == InternetStatus.connected) {
          Cm.showSnackBar(
            navigatorKey.currentContext!,
            message: AppStrings.welcome_back_online,
            bg: AppColors.greencolor,
          );
        }
        if (state.internetstatus == InternetStatus.disconnected) {
          Cm.showSnackBar(
            navigatorKey.currentContext!,
            message: AppStrings.oops_you_are_offline,
            bg: AppColors.redcolor,
          );
        }
      },
      child: BlocBuilder<ThemeBloc, ThemeState>(
        bloc: themeBloc,
        builder: (context, state) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            title: AppLabels.demo_users_app,
            theme: AppTheme.light,
            themeMode: state.mode,
            darkTheme: AppTheme.dark,
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
