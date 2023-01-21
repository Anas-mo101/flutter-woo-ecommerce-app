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

  Map<int, int> itemsQty = {};
  List<Product> uniqueList = [];

  calcCartItems(List order){
    ongoingOrder =  Order(
      order[0],
      order[1],
      order[2],
      order[3],
      order[4],
      order[5],
      order[6],
      order[7],
      order[8],
      order[9],
    );
    ongoingOrder.subtotal = calSubTotalPrice();
    ongoingOrder.tax = ongoingOrder.subtotal  * 0.04;
    ongoingOrder.delv = 10;
    ongoingOrder.total = ongoingOrder.delv + ongoingOrder.tax + ongoingOrder.subtotal;
  }

  int getQty(int id){
    return ongoingOrder.itemsQty[id];
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

}
