import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/modules/checkout/views/billing_page.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_ecommerce_app/src/modules/product/model/product.dart';

import '../models/order.dart';


// store cart item in set() -> uniquely
// keep track of each cart item's qty in may and id as key

class CheckoutController extends GetxController {

  Order ongoingOrder;

  // List<String> paymentOptions = ['Cash On Delivery', 'Credit/Debt Card', 'Online Banking'];
  // int selectedPaymentOptions = 0;
  //
  // List<String> shippingOptions = ['Saudi', 'Egypt', 'Qatar'];
  // int selectedShippingOptions = 0;
  //
  // final cusName = TextEditingController();
  // final cusEmail = TextEditingController();
  // final cusPhone = TextEditingController();
  // final cusBilling = TextEditingController();
  // final cusShipping = TextEditingController();
  // final cusZip = TextEditingController();
  //
  // bool cusNameErr = false;
  // bool cusEmailErr = false;
  // bool cusPhoneErr = false;
  // bool cusBillingErr = false;
  // bool cusShippingErr = false;
  // bool cusZipErr = false;
  // bool cusCountryErr = false;
  //

  Map<int, int> itemsQty = {};
  List<Product> uniqueList = [];

  // togglePaymentOption(String option){
  //   final opt = paymentOptions.indexOf(option);
  //   selectedPaymentOptions = opt == -1 ? 0 : opt;
  //   update();
  // }
  //
  // toggleShippingOption(String option){
  //   final opt = shippingOptions.indexOf(option);
  //   selectedShippingOptions = opt == -1 ? 0 : opt;
  //   update();
  // }

  calcCartItems(Order order){
    ongoingOrder = order;
    ongoingOrder.subtotal = calSubTotalPrice();
    ongoingOrder.tax = ongoingOrder.subtotal  * 0.04;
    ongoingOrder.delv = 10;
    ongoingOrder.total = ongoingOrder.delv + ongoingOrder.tax + ongoingOrder.subtotal;
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

  int getOrderTotalQty() {
    int total = 0;
    ongoingOrder.itemsQty.forEach((key, value) {
      total += value;
    });
    return total;
  }

  double calSubTotalPrice() {
    double price = 0.0;
    ongoingOrder.uniqueList.forEach((element) {
      if(ongoingOrder.itemsQty.containsKey(element.id)){
        price += (element.price * ongoingOrder.itemsQty[element.id]);
      }
    });
    return price;
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


  /// BILLING

  // bool validateCustomerInfo(){
  //
  //   /// Validate Name
  //   if(cusName.value.text.isEmpty){
  //     print(1);
  //     resetError();
  //     cusNameErr = true;
  //     update();
  //     return false;
  //   }
  //
  //   /// Validate Email
  //   if(cusEmail.value.text.isEmpty || !isEmail(cusEmail.value.text)){
  //     print(2);
  //
  //     resetError();
  //     cusEmailErr = true;
  //     update();
  //     return false;
  //   }
  //
  //   /// Validate Phone
  //   if(cusPhone.value.text.isEmpty || !isPhoneNumber(cusPhone.value.text)){
  //     print(3);
  //
  //     resetError();
  //     cusPhoneErr = true;
  //     update();
  //     return false;
  //   }
  //
  //   if(cusBilling.value.text.isEmpty){
  //     print(5);
  //
  //     resetError();
  //     cusBillingErr = true;
  //     update();
  //     return false;
  //   }
  //
  //   // if(selectedShippingOptions){
  //   //   resetError();
  //   //   cusCountryErr = true;
  //   //   update();
  //   //   return false;
  //   // }
  //
  //   /// Validate Billing
  //   if(cusShipping.value.text.isEmpty){
  //     print(4);
  //
  //     resetError();
  //     cusShippingErr = true;
  //     update();
  //     return false;
  //   }
  //
  //
  //   if(cusZip.value.text.isEmpty || !isZipCode(cusZip.value.text)){
  //     print(6);
  //
  //     cusZipErr = true;
  //     update();
  //     return false;
  //   }
  //
  //   resetError();
  //   update();
  //   return true;
  // }
  //
  // resetError(){
  //   cusNameErr = false;
  //   cusEmailErr = false;
  //   cusPhoneErr = false;
  //   cusBillingErr = false;
  //   cusShippingErr = false;
  //   cusZipErr = false;
  // }

  // bool isPhoneNumber(String phone) {
  //   String p = "^(?:[+0]9)?[0-9]{10}\$";
  //   RegExp regExp = new RegExp(p);
  //   return regExp.hasMatch(phone);
  // }
  //
  // bool isEmail(String email) {
  //   String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
  //       "\\@" +
  //       "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
  //       "(" +
  //       "\\." +
  //       "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
  //       ")+";
  //   RegExp regExp = new RegExp(p);
  //   return regExp.hasMatch(email);
  // }
  //
  // bool isZipCode(String zip) {
  //   String p = "^[0-9]{5}(?:-[0-9]{4})?\$";
  //   RegExp regExp = new RegExp(p);
  //   return regExp.hasMatch(zip);
  // }
}
