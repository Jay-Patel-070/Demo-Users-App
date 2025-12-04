import 'dart:convert';
import 'package:demo_users_app/cm.dart';
import 'package:demo_users_app/components/appbar_component.dart';
import 'package:demo_users_app/components/button_component.dart';
import 'package:demo_users_app/components/user_listtile_component.dart';
import 'package:demo_users_app/extension.dart';
import 'package:demo_users_app/helper/shared_preference_helper.dart';
import 'package:demo_users_app/main.dart';
import 'package:demo_users_app/screens/auth/login_screen.dart';
import 'package:demo_users_app/screens/theme/bloc/theme_bloc.dart';
import 'package:demo_users_app/screens/theme/bloc/theme_event.dart';
import 'package:demo_users_app/screens/theme/bloc/theme_state.dart';
import 'package:demo_users_app/screens/users/bloc/users_bloc.dart';
import 'package:demo_users_app/screens/users/bloc/users_event.dart';
import 'package:demo_users_app/screens/users/bloc/users_state.dart';
import 'package:demo_users_app/screens/users/data/user_datasource.dart';
import 'package:demo_users_app/screens/users/user_profile_screen.dart';
import 'package:demo_users_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/user_datarepository.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final SharedPrefsHelper sharedprefshelper = SharedPrefsHelper();
  final UsersBloc usersBloc = UsersBloc(UserDatarepository(UserDatasource()));
  // LoginResponseModel userData = getUserData();
  int isselected = themeBloc.state.mode == ThemeMode.system
      ? 2
      : themeBloc.state.mode == ThemeMode.dark
      ? 1
      : 0;

  @override
  void initState() {
    // if (userData == null) {
      usersBloc.add(FetchAuthUserEvent());
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UsersBloc, UsersState>(
      bloc: usersBloc,
      listener: (context, state) {
        if (state.usersapicallstate == ApiCallState.success) {
          // sharedprefshelper.saveData(
          //   LocalStorageKeys.userData,
          //   jsonEncode(state.userresponse?.toJson()),
          // );
          userData = state.userresponse;
        }
        if (state.usersapicallstate == ApiCallState.failure) {
          Cm.showSnackBar(context, message: state.error.toString());
        }
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 50),
          child: AppbarComponent(title: AppLabels.settings,centertitle: true,),
        ),
        body: BlocBuilder<UsersBloc, UsersState>(
          bloc: usersBloc,
          builder: (context, state) {
            if (state.usersapicallstate == ApiCallState.busy || userData == null) {
              return Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppPadding.lg,
                vertical: AppPadding.lg,
              ),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.greywithshade.withValues(alpha: 0.2),
                              width: 2,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 60,
                            backgroundColor: AppColors.whitecolor,
                            backgroundImage: NetworkImage("${userData?.image}"),
                          ),
                        ),
                        sb(20),
                        Text(
                          '${userData?.firstName} ${userData?.lastName}',
                          style: TextStyle(
                            fontSize: AppFontSizes.xl,
                            fontFamily: Appfonts.robotobold,
                          ),
                        ),
                        Text(
                          '${userData?.email}',
                          style: TextStyle(
                            color: AppColors.greycolor,
                            fontSize: AppFontSizes.lg,
                            fontFamily: Appfonts.roboto,
                          ),
                        ),
                      ],
                    ).onTapEvent(() {
                      callNextScreen(context, UserProfileScreen());
                    },),
                  ),
                  sb(20),
                  Text(
                    AppLabels.theme,
                    style: TextStyle(
                      fontSize: AppFontSizes.xl,
                      fontFamily: Appfonts.robotomedium,
                      color: AppColors.greywithshade,
                    ),
                  ),
                  sb(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      themeWidget(
                        bgcolor: AppColors.whitecolor,
                        bordercolor: AppColors.blackcolor,
                        isSelected: isselected == 0 ? true : false,
                        title: 'Light',
                      ).onTapEvent(() {
                        themeBloc.add(SetThemeEvent(ThemeMode.light));
                        setState(() {
                          isselected = 0;
                        });
                      }),
                      themeWidget(
                        bgcolor: AppColors.blackcolor,
                        bordercolor: AppColors.whitecolor.withValues(
                          alpha: 0.5,
                        ),
                        isSelected: isselected == 1 ? true : false,
                        title: 'Dark',
                      ).onTapEvent(() {
                        themeBloc.add(SetThemeEvent(ThemeMode.dark));
                        setState(() {
                          isselected = 1;
                        });
                      }),
                      themeWidget(
                        bgcolor: AppColors.greycolor.withValues(alpha: 0.4),
                        bordercolor: isselected == 0
                            ? AppColors.blackcolor
                            : AppColors.whitecolor.withValues(alpha: 0.5),
                        isSelected: isselected == 2 ? true : false,
                        title: 'System',
                      ).onTapEvent(() {
                        themeBloc.add(SetThemeEvent(ThemeMode.system));
                        setState(() {
                          isselected = 2;
                        });
                      }),
                    ],
                  ),
                  sb(20),
                  Text(
                    AppLabels.account,
                    style: TextStyle(
                      fontSize: AppFontSizes.xl,
                      fontFamily: Appfonts.robotomedium,
                      color: AppColors.greywithshade,
                    ),
                  ),
                  sb(20),
                  tile(
                    title: AppLabels.logout,
                    icon: Icons.logout_outlined,
                    ontap: onTapLogOut,
                    showicon: false,
                    color: AppColors.redcolor,
                    titlecolor: AppColors.redcolor,
                  ),
                  sb(20),
                  tile(
                    title: AppLabels.delete_account,
                    icon: Icons.logout_outlined,
                    ontap: onTapLogOut,
                    showicon: false,
                    color: AppColors.redcolor,
                    titlecolor: AppColors.redcolor,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget themeWidget({
    required String title,
    required Color bordercolor,
    required Color bgcolor,
    required bool isSelected,
  }) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppRadius.xl),
              topRight: Radius.circular(AppRadius.xl),
            ),
            border: Border(
              right: BorderSide(
                width: 4,
                color: isSelected ? AppColors.primarycolor : Colors.transparent,
              ),
              left: BorderSide(
                width: 4,
                color: isSelected ? AppColors.primarycolor : Colors.transparent,
              ),
              top: BorderSide(
                width: 4,
                color: isSelected ? AppColors.primarycolor : Colors.transparent,
              ),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: bgcolor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppRadius.lg),
                topRight: Radius.circular(AppRadius.lg),
              ),
              border: Border(
                right: BorderSide(width: 4, color: bordercolor),
                left: BorderSide(width: 4, color: bordercolor),
                top: BorderSide(width: 4, color: bordercolor),
              ),
            ),
            height: 70,
            width: 60,
            child: Stack(
              children: [
                Positioned(
                  top: 4,
                  left: 15,
                  child: Container(
                    width: 20,
                    height: 6,
                    decoration: BoxDecoration(
                      color: bordercolor,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                  ),
                ),
              ],
            ),
          ).withPadding(padding: EdgeInsets.all(2)),
        ),
        sb(5),
        Text(
          title,
          style: TextStyle(
            fontSize: AppFontSizes.md,
            fontFamily: Appfonts.robotomedium,
            color: AppColors.greywithshade,
          ),
        ),
      ],
    );
  }

  onTapLogOut() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          titlePadding: .only(left:AppPadding.lg,right:AppPadding.lg,top:AppPadding.md),
          actionsPadding: .symmetric(horizontal:AppPadding.lg,vertical: AppPadding.md),
          contentPadding: .symmetric(horizontal:AppPadding.lg,vertical: AppPadding.sm),
          title: Text('Logout Confirmation'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to log out?'),
                sb(5),
                Text('You will need to sign in again to access your account.'),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 70,
                  height: 40,
                  child: ButtonComponent(ontap: () {
                    Navigator.of(dialogContext).pop();
                  }, buttontitle: 'Cancel'),
                ),
                SizedBox(
                  width: 70,
                  height: 40,
                  child: ButtonComponent(ontap: () {
                    sharedprefshelper.clearAllData();
                    callNextScreenAndClearStack(context, LoginScreen());
                  }, buttontitle: 'Logout',bgcolor: AppColors.redcolor,),
                ),
              ],
            )

          ],
        );
      },
    );

  }

  Widget tile({
    required String title,
    required IconData icon,
    required VoidCallback ontap,
    String? subtitle,
    bool? showicon = true,
    Color? color,
    Color? titlecolor,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.1, color: AppColors.secondarycolor),
        ),
      ),
      child: ListTile(
        onTap: ontap,
        leading: Icon(icon, color: color),
        title: Text(
          title,
          style: TextStyle(
            fontFamily: Appfonts.roboto,
            fontSize: AppFontSizes.xl,
            color: titlecolor,
          ),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle,
                style: TextStyle(
                  fontFamily: Appfonts.roboto,
                  fontSize: AppFontSizes.md,
                  color: AppColors.greywithshade,
                ),
              )
            : null,
        trailing: showicon == true
            ? Icon(Icons.chevron_right_rounded, color: AppColors.greywithshade)
            : SizedBox.shrink(),
      ),
    );
  }
}
