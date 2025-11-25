import 'package:demo_users_app/screens/auth/bloc/auth_event.dart';
import 'package:demo_users_app/screens/auth/bloc/auth_state.dart';
import 'package:demo_users_app/screens/auth/data/auth_datarepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthDatarepository authdatarepository;
  AuthBloc(this.authdatarepository) : super(AuthInitialState()) {
    on<LoginButtonPressEvent>(onloginbuttonpressevent);
  }
  onloginbuttonpressevent(LoginButtonPressEvent event, emmit) async {
    emmit(state.copywith(apicallstate: LoginApiCallState.busy));
    try {
      final result = await authdatarepository.loginapi(
        username: event.username,
        password: event.password,
      );
      emmit(state.copywith(apicallstate: LoginApiCallState.busy));
      result.when(success: (data) {
        emmit(
          state.copywith(
            apicallstate: LoginApiCallState.success,
            loginresponsemodel: result.data,
          ),
        );
      }, failure: (error) {
        emmit(state.copywith(apicallstate: LoginApiCallState.failure,error: error));
      },);
      emmit(state.copywith(apicallstate: LoginApiCallState.none));
    } catch (e) {
      emmit(state.copywith(apicallstate: LoginApiCallState.busy));
      emmit(state.copywith(apicallstate: LoginApiCallState.failure));
    }
  }
}
