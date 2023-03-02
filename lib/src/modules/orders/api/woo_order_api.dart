import 'package:flutter_ecommerce_app/src/api/data%20providers/base_api.dart';
import 'package:flutter_ecommerce_app/src/api/endpoint.dart';
import 'package:get/get.dart';
import '../../profile/middleware/auth_middleware.dart';
import '../model/woo_user_orders.dart';

class WooOrderApi extends BaseApi {


  Future<List<WooUserOrder>> getOrder() async {
    try{
      int id = Get.find<AuthService>().authedUser.id;
      var endpoint = EndPoints.getOrder(id);
      var response = await BaseApi().get(endpoint, mHeader: {
        "Authorization": basicAuth
      });
      return response.map<WooUserOrder>((e) => WooUserOrder.fromJson(e)).toList();
    }catch(e){
      print('WooOrderApi getOrder() failed: ${e}');
      throw Exception();
    }
  }
}