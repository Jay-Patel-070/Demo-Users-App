import 'package:demo_users_app/http/my_app_http.dart';
import 'package:demo_users_app/utils/api_constant.dart';

class UserDatasource {
  Future<dynamic> getcurrentuser() async {
    try {
      final response = await getMethod(endpoint: ApiConstant.authuser);
      return response;
    } catch (e) {
      print(e);
    }
  }
}