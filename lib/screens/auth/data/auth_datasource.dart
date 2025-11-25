import 'package:demo_users_app/http/my_app_http.dart';
import 'package:demo_users_app/utils/api_constant.dart';

class AuthDatasource {
  Future<dynamic> loginapi({
    required String username,
    required String password,
  }) async {
    try {
      Map<String,dynamic> params = {
            "username": username,
            "password": password,
      };
      final response = await postMethod(endpoint: ApiConstant.login,body: params);
      return response;
    } catch (e) {
      print(e);
    }
  }
}
