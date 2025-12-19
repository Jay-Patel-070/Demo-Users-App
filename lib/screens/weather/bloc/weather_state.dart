import 'package:demo_users_app/screens/auth/bloc/auth_state.dart';
import 'package:demo_users_app/screens/weather/model/weather_model.dart';

class WeatherInitialState extends WeatherState{}
class WeatherState {
  ApiCallState weatherapicallstate;
  String? error;
  WeatherModel? weatherModel;
  WeatherState({this.weatherapicallstate = ApiCallState.none,this.weatherModel,this.error});

  WeatherState copywith({ApiCallState? weatherapicallstate,String? error,WeatherModel? weathermodel}) {
    return WeatherState(
    weatherapicallstate: weatherapicallstate ?? this.weatherapicallstate,
      error: error ?? this.error,
      weatherModel: weathermodel ?? this.weatherModel
    );
}
}
