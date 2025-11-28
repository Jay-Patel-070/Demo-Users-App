import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:demo_users_app/http/internet_bloc/internet_event.dart';
import 'package:demo_users_app/http/internet_bloc/internet_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  late StreamSubscription<List<ConnectivityResult>> connectivitySubscription;
  bool hasInitialStatusEmitted = false; // Skip first load
  InternetBloc() : super(InternetInitialState()) {
    connectivitySubscription = Connectivity().onConnectivityChanged.listen((
      List<ConnectivityResult> result,
    ) {
      final isConnected =
          result.isNotEmpty && !result.contains(ConnectivityResult.none);
      add(CheckInternetConnectivityEvent(isconnected: isConnected));
    });
    on<CheckInternetConnectivityEvent>(onCheckInternetConnectivityEvent);
  }
  onCheckInternetConnectivityEvent(
    CheckInternetConnectivityEvent event,
    emit,
  ) async {
    // Skip showing snackbar on app start
    if (!hasInitialStatusEmitted) {
      hasInitialStatusEmitted = true;
      return;
    }
    // emit(state.copywith(internetstatus: InternetStatus.loading));
    if (event.isconnected) {
      emit(state.copywith(internetstatus: InternetStatus.connected));
    } else {
      emit(state.copywith(internetstatus: InternetStatus.disconnected));
    }
  }
}
