import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../product/model/product.dart';
import '../api/woo_order_api.dart';
import '../model/woo_user_orders.dart';

class OrdersController extends GetxController {

  bool isLoading = true;
  bool isOrderProductsLoading = true;
  List<WooUserOrder> orders = [];
  List<Product> orderProduct = [];

  @override
  void onInit() {
    init();
    super.onInit();
  }

  void init() async {
    await _setOrders();

    isLoading = false;
    await update();
  }


  Future<void> _setOrders() async {
    try{
      orders = await WooOrderApi().getOrder();
    }catch(e){
      orders = [];
    }
  }

}
