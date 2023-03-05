import 'dart:convert';

import 'package:flutter_ecommerce_app/src/api/data%20providers/base_api.dart';
import 'package:flutter_ecommerce_app/src/api/endpoint.dart';
import 'package:get/get.dart';
import '../../profile/middleware/auth_middleware.dart';
import '../model/user_complain.dart';
import '../model/user_complain_init.dart';

class UserComplainsApi extends BaseApi {

  Future<UserComplain> createComplains(UserComplainInit complainInit) async {
    try{
      int id = Get.find<AuthService>().authedUser.id;
      String email = Get.find<AuthService>().authedUser.email;
      complainInit.userId = id.toString();
      complainInit.userEmail = email.toString();
      var endpoint = EndPoints.createComplain();
      var response = await BaseApi().post(
          endpoint,
          jsonEncode(complainInit.toJson()),
          mHeader: BaseApi.headers
      );
      return UserComplain.fromJson(response);
    }catch(e){
      print('UserComplainsApi createComplains() failed: ${e}');
      throw Exception();
    }
  }

  Future<UserComplain> respondComplain(String message, String complainID) async {
    try{
      int id = Get.find<AuthService>().authedUser.id;
      var body = jsonEncode({
        'user_id': id.toString(),
        "message": message,
        "complain_id": complainID
      });
      var endpoint = EndPoints.respondComplain();
      var response = await BaseApi().post(
          endpoint,
          body,
          mHeader: BaseApi.headers
      );
      return UserComplain.fromJson(response);
    }catch(e){
      print('UserComplainsApi respondComplain() failed: ${e}');
      throw Exception();
    }
  }

  Future<List<UserComplain>> getComplains() async {
    try{
      int id = Get.find<AuthService>().authedUser.id;
      var endpoint = EndPoints.getComplains(id.toString());
      var response = await BaseApi().get(endpoint, mHeader: BaseApi.headers);
      return response.map<UserComplain>((e) => UserComplain.fromJson(e)).toList();
    }catch(e){
      print('UserComplainsApi getComplains() failed: ${e}');
      throw Exception();
    }
  }

  Future<UserComplain> getComplain(String cid) async {
    try{
      var endpoint = EndPoints.getComplain(cid);
      var response = await BaseApi().get(endpoint, mHeader: BaseApi.headers);
      return UserComplain.fromJson(response);
    }catch(e){
      print('UserComplainsApi getComplain() failed: ${e}');
      throw Exception();
    }
  }
}