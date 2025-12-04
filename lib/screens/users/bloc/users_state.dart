
import 'package:demo_users_app/screens/users/model/user_response.dart';

enum ApiCallState { none, busy, success, failure }

class UsersInitialState extends UsersState {}

class UsersState {
  ApiCallState usersapicallstate;
  ApiCallState editusersapicallstate;
  UserResponse? userresponse;
  String? error;
  UsersState({this.usersapicallstate = ApiCallState.none, this.editusersapicallstate = ApiCallState.none, this.userresponse,this.error});
  UsersState copywith({
    ApiCallState? usersapicallstate,
    ApiCallState? editusersapicallstate,
    UserResponse? userresponse,
    String? error
  }) {
    return UsersState(
        usersapicallstate: usersapicallstate ?? this.usersapicallstate,
        userresponse: userresponse ?? this.userresponse,
        editusersapicallstate: editusersapicallstate ?? this.editusersapicallstate,
        error: error ?? this.error
    );
  }
}
