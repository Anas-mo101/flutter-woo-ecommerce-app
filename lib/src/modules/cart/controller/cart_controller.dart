import 'dart:convert';
import 'package:flutter_ecommerce_app/src/modules/checkout/models/woo_order.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_ecommerce_app/src/modules/product/model/product.dart';


// store cart item in set() -> uniquely
// keep track of each cart item's qty in may and id as key
class CartController extends GetxController {

  @override
  void onInit() {
    loadCartItems();
    super.onInit();
  }

  // tracks quantity of products in cart
  // Map<int, int> itemsQty = {};
  // unique list on products in cart
  List<Product> uniqueList = [];
  // cart list for wooCommerce order
  List<LineItems> wooCartItems = [];

  int getQty(int id){
    for(var i = 0; i < wooCartItems.length; i++){
      if(wooCartItems[i].productId == id){
        return wooCartItems[i].quantity;
      }
    }
    return 0;
  }

  List<Product> getCart() {
    return uniqueList.toList();
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
    uniqueList.forEach((element) {
      LineItems found = wooCartItems.firstWhere((e) => e.productId == element.id);
      price += element.price * found.quantity;
    });
    return price;
  }

  static Future<int> getQtyFromCart(int id) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cartModel = prefs.getStringList("cartModel") ?? [];
    var wooCartModel = cartModel.map((item) => LineItems.fromJson(jsonDecode(item))).toList();

    int count = 0;
    wooCartModel.forEach((element) {
      if(element.productId == id){
        count = element.quantity;
      }
    });
    return count;
  }

  static Future<void> addToCart(Product item ,{int variantId}) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList("cart") ?? [];
    List<String> cartModel = prefs.getStringList("cartModel") ?? [];

    List<Product> uniqueList = cart.map<Product>((e) =>
        Product.fromJson(jsonDecode(e))).toList();

    List<LineItems> wooCartModel = cartModel.map((e) =>
        LineItems.fromJson(jsonDecode(e))).toList();

    bool existFlag = false;
    uniqueList.forEach((element) => { if(item.id == element.id) existFlag = true });
    if(!existFlag) uniqueList.add(item); // fix condition for addition

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
        wooCartModel.add(LineItems(
          productId: item.id,
          quantity: 1,
          variationId: variantId
        ));
      }else{
        wooCartModel.add(LineItems(
          productId: item.id,
          quantity: 1,
        ));
      }
    }

    prefs.setStringList("cartModel", wooCartModel.map((item) => jsonEncode(item?.toJson())).toList());
    prefs.setStringList("cart", uniqueList.map((item) => jsonEncode(item?.toJson())).toList());
  }

  static Future<void> emptyCart() async {
    final prefs = await SharedPreferences.getInstance();
    // prefs.setStringList("cartQty", []);
    // prefs.setStringList("cart", []);
    prefs.setStringList("cartModel", []);
  }

  void removeFromCart(Product item) {
    for(var i = 0; i < wooCartItems.length; i++){
      if(wooCartItems[i].productId == item.id){
          if(wooCartItems[i].quantity <= 1){
            uniqueList.removeWhere((element) => item.id == element.id);
            wooCartItems.removeWhere((element) => item.id == element.productId);
          }else{
            wooCartItems[i].quantity--;
          }
          break;
      }
    }

    _saveCartItems();
    update();
  }

  void _saveCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList("cart", uniqueList.map((item) => jsonEncode(item?.toJson())).toList());
    prefs.setStringList("cartModel", wooCartItems.map((item) => jsonEncode(item?.toJson())).toList());
  }

  void loadCartItems() async {
    final prefs = await SharedPreferences.getInstance();

    List<String> cart = prefs.getStringList("cart") ?? [];
    uniqueList = cart.map((item) => Product.fromJson(jsonDecode(item))).toList();

    List<String> cartModel = prefs.getStringList("cartModel") ?? [];
    wooCartItems = cartModel.map((item) => LineItems.fromJson(jsonDecode(item))).toList();
    update();
  }
}
