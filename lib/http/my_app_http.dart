import 'dart:convert';
import 'dart:developer';

import 'package:demo_users_app/cm.dart';
import 'package:http/http.dart' as http;

import '../utils/api_constant.dart';

Future<dynamic> postMethod({
  required String endpoint,
  Object? body,
  Map<String, String>? headers,
}) async {
  try {
    final url = Uri.parse(ApiConstant.baseurl+endpoint);
    final requestHeaders = headers ?? getSessionData();
    log("--------- URL ---------- $url");
    log("---------- Request ----------${jsonEncode(body)}");
    final response = await http.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(body),
    );
    log("----------- Response -----------${response}");
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
    print("---------- Token ------- ${getAccessToken()}");
    final requestHeaders = {
      ...getSessionData(),
      ...?headers,
      "Authorization": "Bearer ${getAccessToken()}",
    };

    log("--------- URL (GET) ---------- $url");
    log("--------- Headers ---------- $requestHeaders");

    final response = await http.get(
      url,
      headers: requestHeaders,
    );

    log("----------- GET Response ----------- ${response.body}");
    return response;
  } catch (e) {
    log("GET ERROR $e");
  }
}


Map<String, String> getSessionData() {
  return {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };
}