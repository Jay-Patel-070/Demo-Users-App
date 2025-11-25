import 'dart:convert';
import 'package:demo_users_app/bottom_navigation_barr.dart';
import 'package:demo_users_app/cm.dart';
import 'package:demo_users_app/components/button_component.dart';
import 'package:demo_users_app/components/textfield_component.dart';
import 'package:demo_users_app/helper/shared_preference_helper.dart';
import 'package:demo_users_app/screens/auth/bloc/auth_bloc.dart';
import 'package:demo_users_app/screens/auth/bloc/auth_event.dart';
import 'package:demo_users_app/screens/auth/bloc/auth_state.dart';
import 'package:demo_users_app/screens/auth/data/auth_datarepository.dart';
import 'package:demo_users_app/screens/auth/data/auth_datasource.dart';
import 'package:demo_users_app/screens/auth/model/login_response_model.dart';
import 'package:demo_users_app/screens/auth/signup_screen.dart';
import 'package:demo_users_app/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obsecure = true;
  TextEditingController usernamecontroller = TextEditingController(text: kDebugMode ? 'emilys' : '');
  TextEditingController passwordcontroller = TextEditingController(text: kDebugMode ? 'emilyspass' : '');
  FocusNode usernamefocusnode = FocusNode();
  FocusNode passwordfocusnode = FocusNode();
  final _formkey = GlobalKey<FormState>();
  AuthDatasource authdatasource = AuthDatasource();
  final AuthBloc authBloc = AuthBloc(AuthDatarepository(AuthDatasource()));
  SharedPrefsHelper sharedprefshelper = SharedPrefsHelper();
  LoginResponseModel? loginlocalresponse;

  @override
  void initState() {
    super.initState();
    usernamefocusnode = FocusNode();
    passwordfocusnode = FocusNode();
  }

  @override
  void dispose() {
    usernamefocusnode.dispose();
    passwordfocusnode.dispose();
    usernamecontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      bloc: authBloc,
      listener: (context, state) async{
        if (state.apicallstate == LoginApiCallState.success) {
         await sharedprefshelper.saveData(LocalStorageKeys.accessToken, state.loginresponsemodel?.accessToken);
         Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => BottomNavigationBarr()));
        }else if (state.apicallstate == LoginApiCallState.failure){
          Cm.showSnackBar(context, message: state.error.toString());
        }
      },
      child: Scaffold(
        body: BlocBuilder<AuthBloc, AuthState>(
          bloc: authBloc,
          builder: (context, state) {
              return SafeArea(
                child: Padding(
                  padding: .symmetric(horizontal: AppPadding.lg),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formkey,
                        child: Column(
                          mainAxisAlignment: .center,
                          children: [
                            Text(
                              AppStrings.log_in_to_your_account,
                              style: TextStyle(
                                fontSize: AppFontSizes.display,
                                fontFamily: Appfonts.robotobold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 30),
                            TextfieldComponent(
                              focusnode: usernamefocusnode,
                              controller: usernamecontroller,
                              hinttext: AppStrings.enter_your_username,
                              prefixicon: Icon(Icons.email_outlined),
                              label: AppLabels.user_name,
                              validator: (value) {
                                return Cm.validate(value, AppLabels.user_name,usernamefocusnode);
                              },
                            ),
                            SizedBox(height: 20),
                            TextfieldComponent(
                              focusnode: passwordfocusnode,
                              controller: passwordcontroller,
                              hinttext: AppStrings.enter_your_password,
                              prefixicon: Icon(Icons.lock_outlined),
                              obsecuretext: obsecure,
                              suffixicontap: () {
                                setState(() {
                                  obsecure = !obsecure;
                                });
                              },
                              suffixicon: obsecure == true
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              label: AppLabels.password,
                              validator: (value) {
                                return Cm.validate(value, AppLabels.password,passwordfocusnode);
                              },
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                AppStrings.forgot_password,
                                style: TextStyle(
                                  color: AppColors.primarycolor,
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.primarycolor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            ButtonComponent(
                              buttontitle: AppLabels.login,
                              ontap: () => onpressLogin(),
                              isloading: state.apicallstate == LoginApiCallState.busy ? true : false,
                            ),
                            SizedBox(height: 50),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(AppStrings.new_to_our_app),
                                TextButton(
                                  onPressed: () => onpressNewToOurApp(),
                                  child: Text(
                                    AppLabels.create_account,
                                    style: TextStyle(
                                      color: AppColors.primarycolor,
                                      decoration: TextDecoration.underline,
                                      decorationColor: AppColors.primarycolor,
                                      fontFamily: Appfonts.roboto,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
        ),
      ),
    );
  }

  onpressNewToOurApp() {
    FocusScope.of(context).unfocus();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignupScreen()),
    );
  }

  onpressLogin() {
    FocusScope.of(context).unfocus();
    Cm.focusGiven = false;
    if (_formkey.currentState?.validate() == true) {
      authBloc.add(
        LoginButtonPressEvent(
          username: usernamecontroller.text,
          password: passwordcontroller.text,
        ),
      );
    }
  }
}
