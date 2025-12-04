import 'package:demo_users_app/screens/users/bloc/users_event.dart';
import 'package:demo_users_app/screens/users/bloc/users_state.dart';
import 'package:demo_users_app/screens/users/data/user_datarepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UserDatarepository userDatarepository;
  UsersBloc(this.userDatarepository) : super(UsersInitialState()) {
    on<FetchAuthUserEvent>(onFetchAuthUserEvent);
    on<UpdateAuthUserEvent>(onUpdateAuthUserEvent);
  }


  onFetchAuthUserEvent(FetchAuthUserEvent event, emmit) async {
    emmit(state.copywith(usersapicallstate: ApiCallState.busy));
    try {
      final result = await userDatarepository.getcurrentuser();
      emmit(state.copywith(usersapicallstate: ApiCallState.busy));
      result.when(success: (data) {
        emmit(
          state.copywith(
            usersapicallstate: ApiCallState.success,
            userresponse: result.data,
          ),
        );
      }, failure: (error) {
        emmit(state.copywith(usersapicallstate: ApiCallState.failure,error: error));
      },);
      emmit(state.copywith(usersapicallstate: ApiCallState.none));
    } catch (e) {
      emmit(state.copywith(usersapicallstate: ApiCallState.busy));
      emmit(state.copywith(usersapicallstate: ApiCallState.failure));
    }
  }


  onUpdateAuthUserEvent(UpdateAuthUserEvent event, emmit) async {
    emmit(state.copywith(editusersapicallstate: ApiCallState.busy));
    try {
      final result = await userDatarepository.updatecurrentuser(id: event.id!,params: event.params);
      emmit(state.copywith(editusersapicallstate: ApiCallState.busy));
      result.when(success: (data) {
        emmit(
          state.copywith(
            editusersapicallstate: ApiCallState.success,
            userresponse: result.data,
          ),
        );
      }, failure: (error) {
        emmit(state.copywith(editusersapicallstate: ApiCallState.failure,error: error));
      },);
      emmit(state.copywith(editusersapicallstate: ApiCallState.none));
    } catch (e) {
      emmit(state.copywith(editusersapicallstate: ApiCallState.busy));
      emmit(state.copywith(editusersapicallstate: ApiCallState.failure));
    }
  }
}
