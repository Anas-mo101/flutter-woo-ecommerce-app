import 'package:get/get.dart';
import '../../modules/profile/middleware/auth_middleware.dart';
import '../app_data_provider.dart';


/// funnel between fetch data from cache and api accordingly
class BaseApi extends AppDataProvider {

  static Map<String, String> headers = {
    "Content-Type": "application/json",
  };

  BaseApi(){
    final authService = Get.find<AuthService>();
    if(authService.isAuthed()){
      headers['Authorization'] = 'Bearer ${authService.token}';
    }
  }

  Future<dynamic> get(String url) async {
    try {
      return handleResponse('get', url, headers);
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
      return false;
    }
  }

  // Function for handling PUT requests
  Future<dynamic> put(String url, dynamic body) async {
    try {
      return handleResponse('update', url, headers, body: body);
    } catch (e) {
      return false;
    }
  }

  // Function for handling DELETE requests
  Future<dynamic> delete(String url) async {
    try {
      return handleResponse('delete', url, headers);
    } catch (e) {
      return false;
    }
  }
}
