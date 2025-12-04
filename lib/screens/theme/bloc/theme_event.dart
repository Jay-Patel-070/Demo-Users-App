import 'package:flutter/material.dart';

abstract class ThemeEvent {}

class SetThemeEvent extends ThemeEvent {
  final ThemeMode mode;
  SetThemeEvent(this.mode);
}
