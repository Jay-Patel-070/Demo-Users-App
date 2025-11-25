import 'dart:convert';
import 'package:demo_users_app/http/api_result.dart';
import 'package:demo_users_app/screens/auth/data/auth_datasource.dart';
import 'package:demo_users_app/screens/auth/model/login_response_model.dart';
import 'package:http/http.dart';

class AuthDatarepository {
  final AuthDatasource authdatasource;
  AuthDatarepository(this.authdatasource);
  Future<ApiResult<LoginResponseModel>> loginapi({
    required String username,
    required String password,
  }) async {
    try {
      Response result = await authdatasource.loginapi(
        username: username,
        password: password,
      );
      if(result.statusCode == 200 || result.statusCode == 201){
        final data = LoginResponseModel.fromJson(jsonDecode(result.body));
        return ApiResult.success(data: data);
      } else{
        return ApiResult.failure(error: jsonDecode(result.body)['message']);
      }
    } catch (e) {
      return  ApiResult.failure(error: "Something went wrong");
    }
  }
}
