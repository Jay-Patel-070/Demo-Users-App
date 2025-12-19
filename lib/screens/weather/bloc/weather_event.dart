
import 'package:meta/meta.dart';

@immutable
abstract class WeatherEvent {}

class FetchWeatherDataEvent extends WeatherEvent {}