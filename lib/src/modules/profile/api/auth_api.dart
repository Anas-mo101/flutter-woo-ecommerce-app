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
      Get.find<AuthService>().authCurrentUser(AuthProfile(
          response['token'].toString(),
          response['user_display_name'].toString(),
          response['user_email'].toString(),
          response['user_display_name'].toString(),
      ));
      return true;
    }catch(e){
      print('ProductApi authUser failed');
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
      return false;
    }catch(e){
      print('ProductApi validateAuth failed');
      return false;
    }
  }
}