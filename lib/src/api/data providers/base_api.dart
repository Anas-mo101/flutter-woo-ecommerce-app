import 'dart:convert';
import 'package:http/http.dart' as http;
import '../app_data_provider.dart';


// funnel between fetch data from cache and api accordingly
class BaseApi extends AppDataProvider {

  /// Basic Auth
  static const CLIENT_KEY = '';
  static const CLIENT_SECRET = '';
  String basicAuth = 'Basic ' + base64.encode(utf8.encode('$CLIENT_KEY:$CLIENT_SECRET'));

  static Map<String, String> headers = {
    // "Content-Type": "application/json",
    // "Authorization": "Bearer $basicAuth",
  };

  Future<String> loginWithBearerAuth(String url, String email, String password) async {
    final responseJson = await post(url, { "email": email, "password": password });
    if(responseJson.containsKey("access_token")){
      return responseJson["access_token"];
    }else{
      throw Exception("Failed to login, please check your credentials and try again");
    }
  }

   Future<dynamic> get(String url) async {
    try {
      return handleResponse('get',url, headers: headers);
    } catch (e) {
      print('BaseApi GET Failed');
      return false;
    }
  }

// Function for handling POST requests
  Future<dynamic> post(String url, dynamic body) async {
    try {
      return handleResponse('post', url, body: body, headers: headers);
    } catch (e) {
      return false;
    }
  }

// Function for handling PUT requests
  Future<dynamic> put(String url, dynamic body) async {
    try {
      return handleResponse('update', url, body: body, headers: headers);
    } catch (e) {
      return false;
    }
  }

// Function for handling DELETE requests
  Future<dynamic> delete(String url) async {
    try {
      return handleResponse('delete', url, headers: headers);
    } catch (e) {
      return false;
    }
  }

}
