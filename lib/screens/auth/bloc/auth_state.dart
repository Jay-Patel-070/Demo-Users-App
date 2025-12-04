
import 'package:demo_users_app/screens/auth/model/login_response_model.dart';

enum ApiCallState { none, busy, success, failure }

class AuthInitialState extends AuthState {}

class AuthState {
  ApiCallState loginapicallstate;
  LoginResponseModel? loginresponsemodel;
  String? error;
  AuthState({this.loginapicallstate = ApiCallState.none, this.loginresponsemodel,this.error});
  AuthState copywith({
    ApiCallState? loginapicallstate,
    LoginResponseModel? loginresponsemodel,
    String? error
  }) {
    return AuthState(
      loginapicallstate: loginapicallstate ?? this.loginapicallstate,
      loginresponsemodel: loginresponsemodel ?? this.loginresponsemodel,
      error: error ?? this.error
    );
  }
}
