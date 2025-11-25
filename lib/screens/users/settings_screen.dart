import 'dart:convert';
import 'package:demo_users_app/cm.dart';
import 'package:demo_users_app/components/appbar_component.dart';
import 'package:demo_users_app/components/user_listtile_component.dart';
import 'package:demo_users_app/helper/shared_preference_helper.dart';
import 'package:demo_users_app/main.dart';
import 'package:demo_users_app/screens/auth/login_screen.dart';
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

  @override
  void initState() {
    if(userData == null){
    usersBloc.add(FetchAuthUserEvent());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UsersBloc, UsersState>(
      bloc: usersBloc,
      listener: (context, state) {
        if (state.apicallstate == UsersApiCallState.success) {
          sharedprefshelper.saveData(LocalStorageKeys.userData, jsonEncode(state.userresponse?.toJson()));
          userData = state.userresponse;
        }
        if (state.apicallstate == UsersApiCallState.failure) {
          Cm.showSnackBar(context, message: state.error.toString());
        }
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 50),
          child: AppbarComponent(title: AppLabels.settings),
        ),
        body: BlocBuilder<UsersBloc, UsersState>(
          bloc: usersBloc,
          builder: (context, state) {
            if(state.apicallstate == UsersApiCallState.busy){
              return Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.lg, vertical: AppPadding.lg),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  UserListtileComponent(
                    email: "${userData?.email}",
                    name: '${userData?.firstName} ${userData?.lastName}',
                    image: '${userData?.image}',
                    showicon: false,
                  ),
                  sb(20),
                  Text(
                    AppLabels.general,
                    style: TextStyle(
                      fontSize: AppFontSizes.xl,
                      fontFamily: Appfonts.robotomedium,
                      color: AppColors.greywithshade,
                    ),
                  ),
                  sb(20),
                  tile(
                    title: AppLabels.profile,
                    icon: Icons.person_outline,
                    ontap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UserProfileScreen()),
                      );
                    },
                  ),
                  sb(20),
                  tile(
                    title: AppLabels.theme,
                    subtitle: AppLabels.system,
                    icon: Icons.brightness_6_outlined,
                    ontap: () {},
                  ),
                  sb(30),
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

  onTapLogOut() {
    sharedprefshelper.clearAllData();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
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
        leading: Icon(icon, color: color ?? AppColors.blackcolor),
        title: Text(
          title,
          style: TextStyle(
            fontFamily: Appfonts.roboto,
            fontSize: AppFontSizes.xl,
            color: titlecolor ?? AppColors.blackcolor,
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
