import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/modules/checkout/views/billing_page.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_ecommerce_app/src/modules/product/model/product.dart';

import '../../../config/woo_store/woo_store_service.dart';
import '../../../model/woo_product_tax.dart';
import '../../cart/model/cart_item_product.dart';
import '../../cart/model/cart_model.dart';
import '../models/order.dart';
import '../models/woo_order.dart';


class CheckoutController extends GetxController {

  Order ongoingOrder;
  WooOrder currentOrder;
  List<CartModel> cartItems = [];

  @override
  void onInit() {
    var args = Get.arguments;
    if(args is List){
      currentOrder = args[0];
      cartItems = args[1];
      ongoingOrder = Order(
        customerShippingAddress: currentOrder.shipping.address1,
        paymentOption: currentOrder.paymentMethod
      );
      calcCartItems();
    }
    super.onInit();
  }


  void calcLineItemsTax(){
    /// in woo_product tax_class match w woo_tax class
    List<WooTax> taxesRates = Get.find<WooStoreService>().storeTax;
    taxesRates.forEach((element) {
      
    });
    currentOrder.lineItems.forEach((element) {
      var itemsId = element.productId;

    });
  }

  void calcCartItems(){
    ongoingOrder.subtotal = calSubTotalPrice();
    ongoingOrder.tax = ongoingOrder.subtotal  * 0.04;
    ongoingOrder.delv = 10;
    ongoingOrder.total = ongoingOrder.delv + ongoingOrder.tax + ongoingOrder.subtotal;
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

  int getTotalQty() {
    int total = 0;
    currentOrder.lineItems.forEach((element) {
      total += element.quantity;
    });
    return total;
  }

  int getOrderTotalQty() {
    int total = 0;
    currentOrder.lineItems.forEach((element) {
      total += element.quantity;
    });
    return total;
  }

  double calSubTotalPrice() {
    double price = 0.0;
    cartItems.forEach((element) {
      price += (element.product.price * element.quantity);
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
