import 'package:meta/meta.dart';

@immutable
abstract class UsersEvent {}

class FetchAuthUserEvent extends UsersEvent {}

class UpdateAuthUserEvent extends UsersEvent {
  final int? id;
  final Map<String,dynamic> params;
  UpdateAuthUserEvent({required this.params,required this.id});
}