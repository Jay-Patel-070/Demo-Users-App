import 'dart:convert';

import 'package:demo_users_app/features/auth/data/auth_datasource.dart';
import 'package:demo_users_app/features/auth/model/login_response_model.dart';
import 'package:demo_users_app/features/users/data/user_datasource.dart';
import 'package:demo_users_app/features/users/model/user_response.dart';
import 'package:demo_users_app/http/api_result.dart';
import 'package:http/http.dart';

class UserDatarepository {
  final UserDatasource userdatasource;
  UserDatarepository(this.userdatasource);
  Future<ApiResult<UserResponse>> getcurrentuser() async {
    try {
      Response result = await userdatasource.getcurrentuser();
      if(result.statusCode == 200 || result.statusCode == 201){
        final data = UserResponse.fromJson(jsonDecode(result.body));
        return ApiResult.success(data: data);
      } else{
        return ApiResult.failure(error: jsonDecode(result.body)['message']);
      }
    } catch (e) {
      return  ApiResult.failure(error: "Something went wrong");
    }
  }
}