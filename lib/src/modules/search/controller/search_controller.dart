import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:flutter/material.dart';
import '../../product/api/product_api.dart';
import '../../product/model/product.dart';
import '../../product/model/test_product_model.dart';



class SearchController extends GetxController {

  final searchController = TextEditingController();
  bool isLoading = false;
  List<Product> searchResults = [];
  String searchArgs;

  @override
  void onInit() {
    // TODO: implement onInit
    searchArgs = Get.arguments != null ? '${Get.arguments}' : '';
    if(searchArgs != ''){
      searchController.text = searchArgs;
      searchByText(search: searchArgs);
    }
    super.onInit();
  }

  void searchByText({String search = ''}) async {
    try{
      isLoading = true;
      update();

      String test = search ?? searchController.text;
      List<TestProduct> res = await ProductApi.getProducts(
          search: test
      );
      searchResults = [];
      res.forEach((e) {
        searchResults.add(Product(
            id: e.id,
            name: e.title,
            image: e.images ?? [],
            price: e.price.toDouble(),
            category: '...',
            desc: e.description,
            rating: 4,
            availableSizes: [],
            availableSColor: [],
            isliked: false
        ));
      });

      isLoading = false;
    }catch(e){
      isLoading = false;
    }
    update();
  }
}
