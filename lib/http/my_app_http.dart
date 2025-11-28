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
    final url = Uri.parse(ApiConstant.baseurl + endpoint);
    final requestHeaders = headers ?? getSessionData();
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
    final requestHeaders = headers ?? getSessionData();

    log("--------- URL (GET) ---------- $url");
    log("--------- Headers ---------- $requestHeaders");

    final response = await http.get(url, headers: requestHeaders);

    log("----------- GET Response ----------- ${response.body}");
    return response;
  } catch (e) {
    log("GET ERROR $e");
  }
}

Future<dynamic> patchMethod({
  required String endpoint,
  Object? body,
  Map<String, String>? headers,
}) async {
  try {
    final url = Uri.parse(ApiConstant.baseurl + endpoint);
    final requestHeaders = headers ?? getSessionData();

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
    final requestHeaders = headers ?? getSessionData();

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
    final requestHeaders = headers ?? getSessionData();

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

Map<String, String> getSessionData() {
  Map<String, String> headers = {};
  headers['Content-Type'] = "application/json";
  headers['Accept'] = "application/json";
  var token = getAccessToken();
  if (token.isNotEmpty) {
    headers['Authorization'] = "Bearer ${getAccessToken()}";
  }
  return headers;
}
