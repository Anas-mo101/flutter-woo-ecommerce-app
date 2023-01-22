import 'dart:convert';
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
  Map<int, int> itemsQty = {};
  // unique list on products in cart
  List<Product> uniqueList = [];

  int getQty(int id){
    return itemsQty[id];
  }

  List<Product> getCart() {
    return uniqueList.toList();
  }

  int getCartTotal() {
    int total = 0;
    itemsQty.forEach((key, value) {
      total += value;
    });
    return total;
  }

  double getPrice() {
    double price = 0.0;
    uniqueList.forEach((element) {
      if(itemsQty.containsKey(element.id)){
        price += (element.price * itemsQty[element.id]);
      }
    });
    return price;
  }

  static Future<int> getQtyFromCart(int id) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cartQty = prefs.getStringList("cartQty") ?? [];
    int count = 0;
    cartQty.forEach((element) {
      List<int> itemId = element.split(':').map((e) => int.parse(e)).toList();
      if(id == itemId[0]){
        count = itemId[1];
      }
    });
    return count;
  }

  static Future<void> addToCart(Product item) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList("cart") ?? [];
    List<String> cartQty = prefs.getStringList("cartQty") ?? [];

    var uniqueList = cart.map((item) => Product.fromJson(jsonDecode(item))).toList();
    Map<int, int> mappedArray = {};
    cartQty.asMap().forEach((index, element) {
      List<int> id = element.split(':').map((e) => int.parse(e)).toList();
      mappedArray[id[0]] = id[1];
    });

    uniqueList.removeWhere((element) => item.id == element.id);
    uniqueList.add(item);

    if(mappedArray.containsKey(item.id)){
      mappedArray[item.id]++;
    }else{
      mappedArray = {...mappedArray,...{item.id: 1}};
    }

    List<String> saveItemCount = [];
    mappedArray.forEach((key, value) {
      saveItemCount.add('$key:$value');
    });
    prefs.setStringList("cartQty", saveItemCount);
    prefs.setStringList("cart", uniqueList.map((item) => jsonEncode(item?.toJson())).toList());
  }

  static Future<void> emptyCart() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList("cartQty", []);
    prefs.setStringList("cart", []);
  }

  void removeFromCart(Product item) {
    if(itemsQty.containsKey(item.id)){
      if(itemsQty[item.id] <= 1){
        itemsQty.remove(item.id);
        uniqueList.removeWhere((element) => item.id == element.id);
      }else{
        itemsQty[item.id]--;
      }
    }

    _saveCartItems();
    update();
  }

  void _saveCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> saveItemCount = [];
    itemsQty.forEach((key, value) => saveItemCount.add('$key:$value'));

    prefs.setStringList("cartQty", saveItemCount);
    prefs.setStringList("cart", uniqueList.map((item) => jsonEncode(item?.toJson())).toList());
  }

  void loadCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList("cart") ?? [];
    List<String> cartQty = prefs.getStringList("cartQty") ?? [];
    uniqueList = cart.map((item) => Product.fromJson(jsonDecode(item))).toList();
    cartQty.forEach((element) {
      List<int> id = element.split(':').map((e) => int.parse(e)).toList();
      itemsQty[id[0]] = id[1];
    });
    update();
  }
}
