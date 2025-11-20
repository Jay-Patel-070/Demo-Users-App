import 'package:demo_users_app/features/auth/model/login_response_model.dart';
import 'package:demo_users_app/features/users/model/user_response.dart';

enum UsersApiCallState { none, busy, success, failure }

class UsersInitialState extends UsersState {}

class UsersState {
  UsersApiCallState apicallstate;
  UserResponse? userresponse;
  String? error;
  UsersState({this.apicallstate = UsersApiCallState.none, this.userresponse,this.error});
  UsersState copywith({
    UsersApiCallState? apicallstate,
    UserResponse? userresponse,
    String? error
  }) {
    return UsersState(
        apicallstate: apicallstate ?? this.apicallstate,
        userresponse: userresponse ?? this.userresponse,
        error: error ?? this.error
    );
  }
}
