import 'dart:convert';

import 'package:absensi_smk_bp/commons/auth_manager.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class APIService {
  // static const String baseUrl = 'http://127.0.0.1:8000/api';
  // static const String baseUrl = '192.168.1.33:8000';
  static const String baseUrl = '192.168.43.138:8000';
  static const String baseApi = '/api';

  static Future<Response> authenticate(Map data) async {
    String endpoint = "/login";
    Uri url = Uri.http(baseUrl, baseApi + endpoint);

    return await http.post(
      url,
      body: jsonEncode(data),
      headers: _initHeadersWithoutToken(),
    );
  }

  static Future<Response> get(
    String endpoint, [
    Map<String, dynamic>? queries,
  ]) async {
    Uri url;

    if (queries != null) {
      url = Uri.http(baseUrl, baseApi + endpoint, queries);
    } else {
      url = Uri.http(baseUrl, baseApi + endpoint);
    }

    return await http.get(
      url,
      headers: await _initHeaders(),
    );
  }

  static Future<Response> post(
    String endpoint,
    Map data, [
    Map<String, dynamic>? queries,
  ]) async {
    Uri url;

    if (queries != null) {
      url = Uri.http(baseUrl, baseApi + endpoint, queries);
    } else {
      url = Uri.http(baseUrl, baseApi + endpoint);
    }
    return await http.post(
      url,
      body: jsonEncode(data),
      headers: await _initHeaders(),
    );
  }

  static Future<Response> put(
    String endpoint,
    Map data, [
    Map<String, dynamic>? queries,
  ]) async {
    Uri url;

    if (queries != null) {
      url = Uri.http(baseUrl, baseApi + endpoint, queries);
    } else {
      url = Uri.http(baseUrl, baseApi + endpoint);
    }
    return await http.put(
      url,
      body: jsonEncode(data),
      headers: await _initHeaders(),
    );
  }

  // static Future<Response> delete(String endpoint) async {
  //   Uri url = Uri.http(baseUrl, '/api$endpoint');
  //   print(url);

  //   return await http.delete(
  //     url,
  //     headers: await _initHeaders(),
  //   );
  // }

  // static String getProfilePicUrl() {
  //   var baseURL = API.baseUrl;
  //   return Uri.http(baseURL, "/api/profile/pp").toString();
  // }

  // static Future<Map<String, String>> makeAuthHeaders() async {
  //   String token = await TokenManager.getToken();
  //   return {
  //     'Authorization': 'Bearer $token',
  //   };
  // }

  static Map<String, String> _initHeadersWithoutToken() {
    return {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
  }

  static Future<Map<String, String>> _initHeaders() async {
    String token = await AuthManager.getToken();

    return {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }
}
