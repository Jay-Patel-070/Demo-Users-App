import 'package:demo_users_app/features/auth/model/login_response_model.dart';

enum LoginApiCallState { none, busy, success, failure }

class AuthInitialState extends AuthState {}

class AuthState {
  LoginApiCallState apicallstate;
  LoginResponseModel? loginresponsemodel;
  String? error;
  AuthState({this.apicallstate = LoginApiCallState.none, this.loginresponsemodel,this.error});
  AuthState copywith({
    LoginApiCallState? apicallstate,
    LoginResponseModel? loginresponsemodel,
    String? error
  }) {
    return AuthState(
      apicallstate: apicallstate ?? this.apicallstate,
      loginresponsemodel: loginresponsemodel ?? this.loginresponsemodel,
      error: error ?? this.error
    );
  }
}
