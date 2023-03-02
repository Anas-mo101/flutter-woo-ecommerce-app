import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../api/woo_order_api.dart';
import '../model/woo_user_orders.dart';

class OrderController extends GetxController {

  bool isLoading = true;

  List<WooUserOrder> orders = [];

  @override
  void onInit() {
    init();
    super.onInit();
  }

  void init() async {
    await _setOrders();

    isLoading = true;
    update();
  }


  Future<void> _setOrders() async {
    try{
      orders = await WooOrderApi().getOrder();
    }catch(e){
      orders = [];
    }
  }




}
