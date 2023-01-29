import 'package:flutter_ecommerce_app/src/modules/product/api/woo_product_api.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../product/model/product.dart';
import '../../product/model/woocommerce_product.dart';
import '../../../model/category.dart';


class SearchController extends GetxController {

  final searchController = TextEditingController();
  bool isLoading = false;
  bool isCategoryLoading = true;
  List<Product> searchResults = [];
  List<Category> categoryList = [];
  String searchArgs;

  @override
  void onInit() {
    // // TODO: implement onInit
    // searchArgs = Get.arguments ?? '';
    // if(searchArgs != ''){
    //   searchController.text = searchArgs;
    //   searchByText(search: searchArgs);
    // }
    getCategories();
    super.onInit();
  }

  void toggleCategoryOptions(Category model) {
    categoryList.forEach((element) {
      element.isSelected = false;
    });
    searchByCategory(model.id.toString());
    model.isSelected = true;
    update();
  }

  void getCategories() async {
    try{
      List<Categories> res = await WooProductApi().getWooCategories();
      print('Products => ${res.length}');

      res.forEach((e) {
        if(e.name != 'Uncategorized') {
          categoryList.add(
              Category(
                  id: e.id,
                  name: e.name,
                  image: ''
              )
          );
        }
      });

    }catch(e){
      print('getHomeProducts: ${e}');
    }
    isCategoryLoading = false;
    update();
  }

  void searchByCategory(String categoryId) async {
    print('searchByText');
    try{
      isLoading = true;
      update();

      List<WooCommerceProduct> res = await WooProductApi().getProducts(
          page: '1',
          per_page: '20',
          category: categoryId
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
