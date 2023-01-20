import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_ecommerce_app/src/model/data.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../model/product.dart';


class ProductController extends GetxController  {

  int product_id;
  Product product;
  bool isLiked = true;

  int selectedAvailableSizes = 0;
  int selectedAvailableSColor = 0;

  void toggleSizeOptions(String selected) {
    for (var element in product.availableSizes.asMap().entries) {
      if(selected == element.value){
        selectedAvailableSizes = element.key;
      }
    }
    update();
  }

  void toggleColorOptions(String selected) {
    for (var element in product.availableSColor.asMap().entries) {
      if(selected == element.value){
        selectedAvailableSColor = element.key;
      }
    }
    update();
  }

  void setProduct(int id){
    product_id = id;
    product = AppData.productList.firstWhere((element) =>  element.id == product_id);
    update();
  }

  @override
  void dispose() {
    super.dispose();
  }

}