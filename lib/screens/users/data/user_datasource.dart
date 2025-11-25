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

  Future<dynamic> updatecurrentuser({required int id ,required Map<String, dynamic> body}) async {
    try {
      final response = await patchMethod(endpoint: ApiConstant.updateauthuser + id.toString(),body: body);
      return response;
    } catch (e) {
      print(e);
    }
  }
}