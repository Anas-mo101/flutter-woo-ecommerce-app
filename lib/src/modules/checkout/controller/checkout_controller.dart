import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../cart/model/cart_item_product.dart';
import '../../cart/model/cart_model.dart';
import '../api/woo_order_requirements_api.dart';
import '../models/order.dart';
import '../models/order_totals.dart';
import '../models/woo_order.dart';


/// calculate cart total from backend
/// and view here

class CheckoutController extends GetxController {

  Order ongoingOrder;
  WooOrder currentOrder;
  List<CartModel> cartItems = [];
  String taxRatePercentage;

  bool isLoading = true;

  @override
  void onInit() {
    var args = Get.arguments;
    if(args is List){
      currentOrder = args[0];
      cartItems = args[1];
      ongoingOrder = Order(
        customerShippingAddress: currentOrder.billing.address1,
        paymentOption: currentOrder.paymentMethod
      );
      setTotals();
    }
    super.onInit();
  }

  int getQty(int id, int varId){
    if(varId != -1){
      for(var i = 0; i < cartItems.length; i++){
        if(cartItems[i].productId == id && cartItems[i].variationId == varId){
          return cartItems[i].quantity;
        }
      }
    }else{
      for(var i = 0; i < cartItems.length; i++){
        if(cartItems[i].productId == id){
          return cartItems[i].quantity;
        }
      }
    }
    return 0;
  }

  List<CartItemProduct> getCart() {
    List<CartItemProduct> items = [];
    cartItems.forEach((e) {
      items.add(CartItemProduct(
          id: e.productId,
          name: e.product.name,
          price: e.product.price,
          image: e.product.image,
          quantity: e.quantity,
          variationIdentifier: e.variationIdentifier.join(', '),
          variationId: e.variationId
      ));
    });
    return items;
  }


  int getOrderTotalQty() {
    int total = 0;
    currentOrder.lineItems.forEach((element) {
      total += element.quantity;
    });
    return total;
  }

  double getTax() {
    return ongoingOrder.tax;
  }

  double getDelv() {
    return ongoingOrder.delv;
  }

  double getGrandTotal() {
    return ongoingOrder.total;
  }

  void setTotals() async {
    try{
      // current order, shipping and shippingline obj are null ??
      OrderTotals totals = await OrderRequirementApi().getTotals({
        "line_items": jsonEncode(currentOrder.lineItems)
      });
      ongoingOrder.subtotal = totals.subtotal;
      ongoingOrder.delv = totals.shippingTotal;
      ongoingOrder.tax = totals.taxTotal;
      ongoingOrder.total = totals.total;

      isLoading = false;
      update();
    } catch (e){
      print('error: $e');
      Get.back();
    }
  }
}
