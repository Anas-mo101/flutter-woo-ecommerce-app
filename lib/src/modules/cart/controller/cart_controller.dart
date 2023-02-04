import 'dart:convert';
import 'package:flutter_ecommerce_app/src/modules/checkout/models/woo_order.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_ecommerce_app/src/modules/product/model/product.dart';

import '../model/cart_item_product.dart';
import '../model/cart_model.dart';


// store cart item in set() -> uniquely
// keep track of each cart item's qty in may and id as key
class CartController extends GetxController {

  @override
  void onInit() {
    loadCartItems();
    super.onInit();
  }

  List<CartModel> wooCartItems = [];

  int getQty(int id, int varId){
    if(varId != -1){
      for(var i = 0; i < wooCartItems.length; i++){
        if(wooCartItems[i].productId == id && wooCartItems[i].variationId == varId){
          return wooCartItems[i].quantity;
        }
      }
    }else{
      for(var i = 0; i < wooCartItems.length; i++){
        if(wooCartItems[i].productId == id){
          return wooCartItems[i].quantity;
        }
      }
    }

    return 0;
  }

  List<CartItemProduct> getCart() {
    List<CartItemProduct> items = [];
    wooCartItems.forEach((e) {

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

  int getCartTotal() {
    int total = 0;
    wooCartItems.forEach((element) {
      total += element.quantity;
    });
    return total;
  }

  double getPrice() {
    double price = 0.0;
    wooCartItems.forEach((element) {
      price += element.product.price * element.quantity;
    });
    return price;
  }

  static Future<int> getQtyFromCart(int id) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cartModel = prefs.getStringList("cartModel") ?? [];
    var wooCartModel = cartModel.map((item) => CartModel.fromJson(jsonDecode(item))).toList();

    int count = 0;
    wooCartModel.forEach((element) {
      if(element.productId == id){
        count = element.quantity;
      }
    });
    return count;
  }

  static Future<void> addToCart(Product item ,{int variantId, List<String> selectedVariations}) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cartModel = prefs.getStringList("cartModel") ?? [];
    List<CartModel> wooCartModel = cartModel.map((e) => CartModel.fromJson(jsonDecode(e))).toList();

    bool notExists = true;
    for(var i = 0; i < wooCartModel.length; i++){
      if(variantId != null){
        if(wooCartModel[i].productId == item.id && wooCartModel[i].variationId == variantId){
          wooCartModel[i].quantity++;
          notExists = false;
          break;
        }
      }else{
        if(wooCartModel[i].productId == item.id){
          wooCartModel[i].quantity++;
          notExists = false;
          break;
        }
      }
    }

    if(notExists){
      if(variantId != null){
        wooCartModel.add(CartModel(
          item.id,
          1,
          item,
          variationId: variantId,
          variationIdentifier: selectedVariations
        ));
      }else{
        wooCartModel.add(CartModel(
          item.id,
          1,
          item,
          variationIdentifier: selectedVariations
        ));
      }
    }

    wooCartModel.forEach((element) {
      print(jsonEncode(element.toJson()));
    });

    prefs.setStringList("cartModel", wooCartModel.map((item) => jsonEncode(item?.toJson())).toList());
  }

  static Future<void> emptyCart() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList("cartModel", []);
  }

  void removeFromCart(int id, int varId) {
    for(var i = 0; i < wooCartItems.length; i++){
      if(varId != -1){
        if(wooCartItems[i].productId == id && wooCartItems[i].variationId == varId){
          if(wooCartItems[i].quantity <= 1){
            wooCartItems.removeWhere((element) => id == element.productId && varId == element.variationId);
          }else{
            wooCartItems[i].quantity--;
          }
          break;
        }
      }else{
        if(wooCartItems[i].productId == id){
          if(wooCartItems[i].quantity <= 1){
            wooCartItems.removeWhere((element) => id == element.productId);
          }else{
            wooCartItems[i].quantity--;
          }
          break;
        }
      }
    }

    _saveCartItems();
    update();
  }

  void _saveCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList("cartModel", wooCartItems.map((item) => jsonEncode(item?.toJson())).toList());
  }

  void loadCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cartModel = prefs.getStringList("cartModel") ?? [];
    wooCartItems = cartModel.map((item) => CartModel.fromJson(jsonDecode(item))).toList();
    update();
  }
}
