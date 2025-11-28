import 'package:meta/meta.dart';

@immutable
abstract class InternetEvent {}

class CheckInternetConnectivityEvent  extends InternetEvent {
  final bool isconnected;
  CheckInternetConnectivityEvent({required this.isconnected});
}
