import 'dart:convert';
import 'package:demo_users_app/http/api_result.dart';
import 'package:demo_users_app/screens/weather/data/weather_datasource.dart';
import 'package:demo_users_app/screens/weather/model/weather_model.dart';
import 'package:http/http.dart';

class WeatherDatarepository {
  final WeatherDatasource weatherDatasource;
  WeatherDatarepository(this.weatherDatasource);
  Future<ApiResult<WeatherModel>> getWeatherdata() async {
    try {
      Response result = await weatherDatasource.getWeatherdata();
      if(result.statusCode == 200){
        final data = WeatherModel.fromJson(jsonDecode(result.body));
        print(data.daily?.temperature2mMax);
        print('insuccess');
        return ApiResult.success(data: data);
      } else{
        print('infailure');
        return ApiResult.failure(error: "error fetching weather data");
      }
    } catch (e) {
      return  ApiResult.failure(error: e.toString());
    }
  }
}