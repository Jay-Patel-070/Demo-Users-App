import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../../utils/utils.dart'; // Path where AppColors is
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(ThemeMode.system)) {
    on<SetThemeEvent>((event, emit) {
      emit(ThemeState(event.mode));
    });
  }
}
