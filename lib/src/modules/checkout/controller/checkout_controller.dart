import 'dart:convert';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_ecommerce_app/src/modules/product/model/product.dart';


// store cart item in set() -> uniquely
// keep track of each cart item's qty in may and id as key

class CheckoutController extends GetxController {

  @override
  void onInit() {
    loadCartItems();
    super.onInit();
  }

  // save each item in cart separatly like a real cart
  List<Product> _items = [];
  Map<int, int> itemsQty = {};
  List<Product> uniquelist = [];

  int getQty(int id){
    return itemsQty[id];
  }

  void setItemsQty(int id, int qty){
    itemsQty[id] = qty;
  }

  bool delItemsQty(Product product){
    if(itemsQty.containsKey(product.id)){
      itemsQty[product.id]--;
      if(itemsQty[product.id] <= 0){
        itemsQty.remove(product.id);
        return true;
      }
    }
    return false;
  }

  List<Product> getCart() {
    return uniquelist.toList();
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
    uniquelist.forEach((element) {
      if(itemsQty.containsKey(element.id)){
        price += (element.price * itemsQty[element.id]);
      }
    });
    return price;
  }

  void _saveCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> saveItemCount = [];
    itemsQty.forEach((key, value) {
      saveItemCount.add('$key:$value');
    });
    prefs.setStringList("cartQty", saveItemCount);
    prefs.setStringList("cart", uniquelist.map((item) => jsonEncode(item?.toJson())).toList());
  }

  void loadCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList("cart");
    List<String> cartQty = prefs.getStringList("cartQty") ?? [];
    uniquelist = cart.map((item) => Product.fromJson(jsonDecode(item))).toList();
    _items = uniquelist;
    cartQty.forEach((element) {
      List<int> id = element.split(':').map((e) => int.parse(e)).toList();
      setItemsQty(id[0], id[1]);
    });
    update();
  }
}
