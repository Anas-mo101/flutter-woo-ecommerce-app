import 'dart:convert';

import 'package:get/get.dart';
import '../../modules/profile/middleware/auth_middleware.dart';
import '../app_data_provider.dart';


/// funnel between fetch data from cache and api accordingly
class BaseApi extends AppDataProvider {
  String client = 'ck_2dc9ec0fac0a8d2d3abe0a5c6d60aaa2cf0f458e';
  String secret = 'cs_ef4ce0ed19140f49e9960f877b718e983c5e77df';
  String basicAuth;

  static Map<String, String> headers = {
    // "Content-Type": "application/json",
  };

  BaseApi(){
    final authService = Get.find<AuthService>();
    if(authService.isAuthed()){
      headers['Authorization'] = 'Bearer ${authService.token}';
    }
    basicAuth = 'Basic ' + base64.encode(utf8.encode('$client:$secret'));
  }

  Future<dynamic> get(String url, {Map<String, String> mHeader}) async {
    try {
      return handleResponse('get', url, mHeader ?? headers);
    } catch (e) {
      print('BaseApi GET Failed');
      return false;
    }
  }

  // Function for handling POST requests
  Future<dynamic> post(String url, dynamic body, {Map<String, String> mHeader}) async {
    try {
      return handleResponse('post', url, mHeader, body: body);
    } catch (e) {
      print('BaseApi POST Failed');
      return false;
    }
  }

  // Function for handling PUT requests
  Future<dynamic> put(String url, dynamic body, {Map<String, String> mHeader}) async {
    try {
      return handleResponse('update', url, mHeader ?? headers, body: body);
    } catch (e) {
      print('BaseApi PUT Failed');
      return false;
    }
  }

  // Function for handling DELETE requests
  Future<dynamic> delete(String url, {Map<String, String> mHeader}) async {
    try {
      return handleResponse('delete', url, mHeader ?? headers);
    } catch (e) {
      print('BaseApi DELETE Failed');
      return false;
    }
  }
}
