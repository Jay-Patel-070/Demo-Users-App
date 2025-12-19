import 'package:demo_users_app/http/my_app_http.dart';
import 'package:http/http.dart' as http;

class WeatherDatasource {
  Future<dynamic> getWeatherdata() async{
    try{
      final response = await http.get(Uri.parse('https://api.open-meteo.com/v1/forecast?latitude=23.03&longitude=72.58&daily=temperature_2m_max&timezone=auto'));
      print(response.body);
        return response;
    } catch(e){
      print(e);
    }
  }
}