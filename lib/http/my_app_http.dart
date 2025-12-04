import 'dart:convert';
import 'dart:developer';

import 'package:demo_users_app/cm.dart';
import 'package:demo_users_app/utils/utils.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
import '../utils/api_constant.dart';

Future<dynamic> postMethod({
  required String endpoint,
  Object? body,
  Map<String, String>? headers,
}) async {
  try {
    final url = Uri.parse(ApiConstant.baseurl + endpoint);
    final requestHeaders = headers ?? await getSessionData();
    log("--------- URL ---------- $url");
    log("---------- Request ----------${jsonEncode(body)}");
    final response = await http.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(body),
    );
    log("----------- Response -----------${response.body}");
    return response;
  } catch (e) {
    log("POST ERROR $e");
  }
}

Future<dynamic> getMethod({
  required String endpoint,
  Map<String, String>? headers,
}) async {
  try {
    final url = Uri.parse(ApiConstant.baseurl + endpoint);
    final requestHeaders = headers ?? await getSessionData();

    log("--------- URL (GET) ---------- $url");
    log("--------- Headers ---------- $requestHeaders");

    final response = await http.get(url, headers: requestHeaders);

    log("----------- GET Response ----------- ${response.body}");
    if(response.statusCode == 401){
      final refreshed = await handleTokenRefresh();
      if (refreshed) {
        return await getMethod(endpoint: endpoint);
      }
    }
    else{
      return response;
    }
  } catch (e) {
    log("GET ERROR $e");
    return null;
  }
}

Future<dynamic> patchMethod({
  required String endpoint,
  Object? body,
  Map<String, String>? headers,
}) async {
  try {
    final url = Uri.parse(ApiConstant.baseurl + endpoint);
    final requestHeaders = headers ?? await getSessionData();

    log("--------- URL (PATCH) ---------- $url");
    log("---------- Request (PATCH) ---------- ${jsonEncode(body)}");

    final response = await http.patch(
      url,
      headers: requestHeaders,
      body: jsonEncode(body),
    );

    log("----------- PATCH Response ----------- ${response.body}");
    return response;
  } catch (e) {
    log("PATCH ERROR $e");
  }
}

Future<dynamic> putMethod({
  required String endpoint,
  Object? body,
  Map<String, String>? headers,
}) async {
  try {
    final url = Uri.parse(ApiConstant.baseurl + endpoint);
    final requestHeaders = headers ?? await getSessionData();

    log("--------- URL (PUT) ---------- $url");
    log("---------- Request (PUT) ---------- ${jsonEncode(body)}");

    final response = await http.put(
      url,
      headers: requestHeaders,
      body: jsonEncode(body),
    );

    log("----------- PUT Response ----------- ${response.body}");
    return response;
  } catch (e) {
    log("PUT ERROR $e");
  }
}

Future<dynamic> deleteMethod({
  required String endpoint,
  Map<String, String>? headers,
  Object? body,
}) async {
  try {
    final url = Uri.parse(ApiConstant.baseurl + endpoint);
    final requestHeaders = headers ?? await getSessionData();

    log("--------- URL (DELETE) ---------- $url");
    log("--------- Headers ---------- $requestHeaders");
    log("---------- Request (DELETE) ---------- ${jsonEncode(body)}");

    final response = await http.delete(
      url,
      headers: requestHeaders,
      body: body != null ? jsonEncode(body) : null,
    );

    log("----------- DELETE Response ----------- ${response.body}");
    return response;
  } catch (e) {
    log("DELETE ERROR $e");
  }
}

Future<Map<String, String>>  getSessionData() async{
  Map<String, String> headers = {};
  headers['Content-Type'] = "application/json";
  headers['Accept'] = "application/json";
  var token = await getAccessToken();
  headers['Authorization'] = "Bearer $token";
  return headers;
}

Future<bool> handleTokenRefresh() async {
  try {
    final refreshToken = await getRefreshToken();

    Map<String,dynamic> params = {
      "refreshToken" : refreshToken,
      "expiresInMins" : 1
    };
    final response = await postMethod(endpoint: ApiConstant.auth_refresh,body: params);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await sharedprefshelper.saveData(
          LocalStorageKeys.accessToken, data['accessToken']);
      await sharedprefshelper.saveData(
          LocalStorageKeys.refreshToken, data['refreshToken']);
      return true;
    }
  } catch (e) {
    log("REFRESH ERROR $e");
  }
  return false;
}
