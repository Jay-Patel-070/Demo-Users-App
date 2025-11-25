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
    emmit(state.copywith(apicallstate: UsersApiCallState.busy));
    try {
      final result = await userDatarepository.getcurrentuser();
      emmit(state.copywith(apicallstate: UsersApiCallState.busy));
      result.when(success: (data) {
        emmit(
          state.copywith(
            apicallstate: UsersApiCallState.success,
            userresponse: result.data,
          ),
        );
      }, failure: (error) {
        emmit(state.copywith(apicallstate: UsersApiCallState.failure,error: error));
      },);
      emmit(state.copywith(apicallstate: UsersApiCallState.none));
    } catch (e) {
      emmit(state.copywith(apicallstate: UsersApiCallState.busy));
      emmit(state.copywith(apicallstate: UsersApiCallState.failure));
    }
  }


  onUpdateAuthUserEvent(UpdateAuthUserEvent event, emmit) async {
    emmit(state.copywith(apicallstate: UsersApiCallState.busy));
    try {
      final result = await userDatarepository.updatecurrentuser(id: event.id!,params: event.params);
      emmit(state.copywith(apicallstate: UsersApiCallState.busy));
      result.when(success: (data) {
        emmit(
          state.copywith(
            apicallstate: UsersApiCallState.success,
            userresponse: result.data,
          ),
        );
      }, failure: (error) {
        emmit(state.copywith(apicallstate: UsersApiCallState.failure,error: error));
      },);
      emmit(state.copywith(apicallstate: UsersApiCallState.none));
    } catch (e) {
      emmit(state.copywith(apicallstate: UsersApiCallState.busy));
      emmit(state.copywith(apicallstate: UsersApiCallState.failure));
    }
  }
}
