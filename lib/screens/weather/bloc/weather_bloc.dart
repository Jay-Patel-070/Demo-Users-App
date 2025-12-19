import 'package:demo_users_app/screens/weather/bloc/weather_event.dart';
import 'package:demo_users_app/screens/weather/bloc/weather_state.dart';
import 'package:demo_users_app/screens/weather/data/weather_datarepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:demo_users_app/screens/auth/bloc/auth_state.dart';

class WeatherBloc extends Bloc<WeatherEvent,WeatherState>{
  WeatherDatarepository weatherDatarepository;
  WeatherBloc(this.weatherDatarepository) : super(WeatherInitialState()){
    on<FetchWeatherDataEvent>(onFetchWeatherDataEvent);
  }
  onFetchWeatherDataEvent(FetchWeatherDataEvent event,emmit) async{
    emmit(state.copywith(weatherapicallstate: ApiCallState.busy));
    try {
      final result = await weatherDatarepository.getWeatherdata();
      emmit(state.copywith(weatherapicallstate: ApiCallState.busy));
      result.when(success: (data) {
        emmit(
          state.copywith(
            weatherapicallstate: ApiCallState.success,
            weathermodel: result.data,
          ),
        );
      }, failure: (error) {
        emmit(state.copywith(weatherapicallstate: ApiCallState.failure,error: error));
      },);
    } catch (e) {
      emmit(state.copywith(weatherapicallstate: ApiCallState.busy));
      emmit(state.copywith(weatherapicallstate: ApiCallState.failure));
    }
  }
}