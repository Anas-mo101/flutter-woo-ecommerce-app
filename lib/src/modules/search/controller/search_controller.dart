import 'package:flutter_ecommerce_app/src/modules/product/api/woo_product_api.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../product/api/product_api.dart';
import '../../product/model/product.dart';
import '../../product/model/test_product_model.dart';
import '../../product/model/woocommerce_product.dart';


class SearchController extends GetxController {

  final searchController = TextEditingController();
  bool isLoading = false;
  List<Product> searchResults = [];
  String searchArgs;

  @override
  void onInit() {
    // // TODO: implement onInit
    // searchArgs = Get.arguments ?? '';
    // if(searchArgs != ''){
    //   searchController.text = searchArgs;
    //   searchByText(search: searchArgs);
    // }
    super.onInit();
  }

  void searchByText({String search = ''}) async {
    print('searchByText');
    try{
      isLoading = true;
      update();

      String test = search ?? searchController.text;

      List<WooCommerceProduct> res = await WooProductApi().getProducts(
          page: '1',
          per_page: '20',
          search: test
      );

      searchResults = [];

      res.forEach((e) {
        List<String> sizes = [];
        List<String> colors = [];
        List<String> images = [];

        if(e.attributes != null){
          e.attributes.forEach((element) {
            if(element.name == 'Sizes'){
              sizes.addAll(element.options);
            }
            if(element.name == 'Colors'){
              colors.addAll(element.options);
            }
          });
        }

        if(e.images != null){
          e.images.forEach((element) {
            images.add(element.src);
          });
        }

        searchResults.add(Product(
            id: e.id,
            name: e.name,
            image: images,
            price: double.parse(e.price),
            category: e.categories != null ? e.categories.first.name : '',
            desc: e.description,
            rating: e.ratingCount,
            availableSizes: sizes,
            availableSColor: colors
        ));
      });

      isLoading = false;
    }catch(e){
      print('searchByText: ${e}');
      isLoading = false;
    }
    update();
  }
}
