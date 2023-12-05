import 'dart:convert';

import 'package:absensi_smk_bp/commons/auth_manager.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class APIService {
  // static const String baseUrl = '192.168.1.33:8000';
  // static const String baseUrl = '192.168.43.138:8000';
  static const String baseUrl = 'smkbinaputracihampelas.sch.id';
  static const String baseApi = '/api';

  static Future<Response> authenticate(Map data) async {
    String endpoint = "/login";
    Uri url = Uri.https(baseUrl, baseApi + endpoint);

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
      url = Uri.https(baseUrl, baseApi + endpoint, queries);
    } else {
      url = Uri.https(baseUrl, baseApi + endpoint);
    }

    return await http.get(
      url,
      headers: await initHeaders(),
    );
  }

  static Future<Response> post(
    String endpoint,
    Map data, [
    Map<String, dynamic>? queries,
  ]) async {
    Uri url;

    if (queries != null) {
      url = Uri.https(baseUrl, baseApi + endpoint, queries);
    } else {
      url = Uri.https(baseUrl, baseApi + endpoint);
    }
    return await http.post(
      url,
      body: jsonEncode(data),
      headers: await initHeaders(),
    );
  }

  static Future<Response> postMultipart(
    String endpoint,
    Map<String, String> data,
    String path,
  ) async {
    Uri url = Uri.https(baseUrl, baseApi + endpoint);
    var request = http.MultipartRequest('POST', url);

    request.headers.addAll(await initHeaders());

    request.fields.addAll(data);
    request.files
        .add(await http.MultipartFile.fromPath('absence_document', path));

    var streamedResponse = await request.send();
    var response = http.Response.fromStream(streamedResponse);
    return response;
  }

  static Future<Response> postProfilePicture(
    String endpoint,
    String path,
  ) async {
    Uri url = Uri.https(baseUrl, baseApi + endpoint, {'_method': 'PUT'});
    var request = http.MultipartRequest('POST', url);

    request.headers.addAll(await initHeaders());
    request.files.add(await http.MultipartFile.fromPath('image', path));

    var streamedResponse = await request.send();
    var response = http.Response.fromStream(streamedResponse);
    return response;
  }

  static Future<Response> put(
    String endpoint,
    Map data, [
    Map<String, dynamic>? queries,
  ]) async {
    Uri url;

    if (queries != null) {
      url = Uri.https(baseUrl, baseApi + endpoint, queries);
    } else {
      url = Uri.https(baseUrl, baseApi + endpoint);
    }
    return await http.put(
      url,
      body: jsonEncode(data),
      headers: await initHeaders(),
    );
  }

  static Map<String, String> _initHeadersWithoutToken() {
    return {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
  }

  static Future<Map<String, String>> initHeaders() async {
    String token = await AuthManager.getToken();

    return {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }
}
