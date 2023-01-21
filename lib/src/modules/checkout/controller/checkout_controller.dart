import 'dart:convert';
import 'package:flutter_ecommerce_app/src/modules/checkout/views/billing_page.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_ecommerce_app/src/modules/product/model/product.dart';


// store cart item in set() -> uniquely
// keep track of each cart item's qty in may and id as key

class CheckoutController extends GetxController {

  double subtotal = 0.0;
  double tax = 0.0;
  double delv = 0.0;
  double total = 0.0;

  List<String> paymentOptions = ['Cash On Delivery', 'Credit/Debt Card', 'Online Banking'];
  int selectedPaymentOptions = 0;

  @override
  void onInit() {
    super.onInit();
  }

  Map<int, int> itemsQty = {};
  List<Product> uniqueList = [];

  togglePaymentOption(String option){
    final opt = paymentOptions.indexOf(option);
    selectedPaymentOptions = opt == -1 ? 0 : opt;
    update();
  }

  setCartItems(List<Product> unique,Map<int, int> qty){
    itemsQty = qty;
    uniqueList = unique;

    subtotal = calSubTotalPrice();
    tax = subtotal  * 0.04;
    delv = 10;
    total = delv + tax + subtotal;
  }

  int getQty(int id){
    return itemsQty[id];
  }

  List<Product> getCart() {
    return uniqueList.toList();
  }

  int getTotalQty() {
    int total = 0;
    itemsQty.forEach((key, value) {
      total += value;
    });
    return total;
  }

  double calSubTotalPrice() {
    double price = 0.0;
    uniqueList.forEach((element) {
      if(itemsQty.containsKey(element.id)){
        price += (element.price * itemsQty[element.id]);
      }
    });
    return price;
  }

  double getTax() {
    return tax;
  }

  double getDelv() {
    return delv;
  }

  double getGrandTotal() {
    return total;
  }
}
