import 'package:get/get.dart';
import '../../../api/endpoint.dart';
import '../../../api/data providers/base_api.dart';
import '../middleware/auth_middleware.dart';

class AuthApi extends BaseApi {

  Future<bool> authUser(String user, String pass) async {
    try{
      String authEndPoint = EndPoints.login();
      var response = await post(authEndPoint,{
        'username': user,
        'password': pass
      });
      if(response['token'] == null) return false;
      print('authUser: ${response['user_display_name']}');
      Get.find<AuthService>().authCurrentUser(AuthProfile.fromJson(response));
      return true;
    }catch(e){
      print('ProductApi authUser failed: $e');
      return false;
    }
  }

  Future<bool> validateAuth(String token) async {
    try{
      String authEndPoint = EndPoints.loginValid();
      var response = await post(authEndPoint, {}, mHeader: {
        "Authorization": "Bearer $token"
      });
      if(response['code'] == 'jwt_auth_valid_token') {
        return true;
      }
    }catch(e){
      print('ProductApi validateAuth failed');
      return false;
    }
  }

  Future<bool> createUser(String user, String pass, String email) async {
    try{
      String registerEndPoint = EndPoints.register();
      var response = await post(registerEndPoint, {
        'username': user,
        'password': pass,
        'email': email
      });
      if(response['data']['status'] == 200) {
        return true;
      }
      return false;
    }catch(e){
      print('ProductApi createUser failed');
      return false;
    }
  }
}