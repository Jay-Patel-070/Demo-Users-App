import 'package:meta/meta.dart';

@immutable
abstract class UsersEvent {}

class FetchAuthUserEvent extends UsersEvent {}