import 'package:flutter_ecommerce_app/src/modules/product/api/woo_product_api.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../config/route.dart';
import '../../product/model/product.dart';
import '../../product/model/woocommerce_product.dart';
import '../../../model/category.dart';


class Filter{
  String maxPrice;
  String minPrice;
  String category;
  String searchKeyword;

  Filter(this.maxPrice,this.minPrice,this.category,this.searchKeyword);
}


class SearchController extends GetxController {

  final searchController = TextEditingController();
  bool isLoading = false;
  bool isCategoryLoading = true;
  List<Product> searchResults = [];
  List<Category> categoryList = [];

  bool searchFilterEnabled = false;
  Filter searchFilter;
  int selectedCategoryFilter = 0;
  RangeValues searchPriceRange = RangeValues(10.0, 1000.0);

  @override
  void onInit() {
    // // TODO: implement onInit
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

  void incomingSearchKeyword(){
    var keyword = Get.arguments as String ?? false;
    if(keyword != false){
      searchController.text = keyword;
    }
  }

  void getCategories() async {
    try{
      List<Categories> res = await WooProductApi().getWooCategories();
      print('Products => ${res.length}');

      res.forEach((e) {
        if(e.name != 'Uncategorized') {
          categoryList.add( Category(id: e.id, name: e.name) );
        }
      });

    }catch(e){
      print('getHomeProducts: ${e}');
    }
    isCategoryLoading = false;
    update();
  }

  void toggleCategoryFilter(String newCategory){
    categoryList.asMap().forEach((key, value) {
      if(value.id == int.parse(newCategory)){
        selectedCategoryFilter = key;
      }
    });
    update();
  }

  void searchByCategory(String categoryId) async {
    try{
      isLoading = true;
      update();

      List<WooCommerceProduct> res = await WooProductApi().getProducts(
          page: '1',
          per_page: '20',
          category: categoryId,
          search: searchController.text ?? ''
      );

      searchResults = [];

      res.forEach((e) {
        List<WooAttributes> sizes = [];
        List<WooAttributes> colors = [];
        List<String> images = [];

        if(e.attributes != null){
          e.attributes.forEach((element) {
            if(element.name == 'Sizes'){
              sizes.add(element);
            }
            if(element.name == 'Colors'){
              colors.add(element);
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

  Future<void> searchByFilter() async {
    try{
      if(searchFilterEnabled == false) return;

      isLoading = true;
      update();

      List<WooCommerceProduct> res = await WooProductApi().getProducts(
          page: '1',
          per_page: '20',
          minPrice: searchFilter.minPrice,
          maxPrice: searchFilter.maxPrice,
          category: searchFilter.category,
          search: searchFilter.searchKeyword
      );

      searchResults = [];
      res.forEach((e) {
        List<WooAttributes> sizes = [];
        List<WooAttributes> colors = [];
        List<String> images = [];
        if(e.attributes != null){
          e.attributes.forEach((element) {
            if(element.name == 'Sizes'){
              sizes.add(element);
            }
            if(element.name == 'Colors'){
              colors.add(element);
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

  void setFilter() async {
    searchFilterEnabled = true;
    searchFilter = Filter(
        searchPriceRange.start.toString(),
        searchPriceRange.end.toString(),
        categoryList[selectedCategoryFilter].id.toString(),
        searchController.text
    );
    Get.offAndToNamed(Routes.search);
    searchByFilter();
  }

  void searchByText({String search = ''}) async {
    print('searchByText');
    try{
      if(search == '') {
        searchResults = [];
        update();
        return;
      }

      categoryList.forEach((element) {
        element.isSelected = false;
      });

      isLoading = true;
      update();

      String test = search ?? searchController.text;
      List<WooCommerceProduct> res = [];
      if(searchFilterEnabled){
        toggleCategoryFilter(searchFilter.category);
        res = await WooProductApi().getProducts(
            page: '1',
            per_page: '20',
            minPrice: searchFilter.minPrice,
            maxPrice: searchFilter.maxPrice,
            category: searchFilter.category,
            search: test
        );
      }else{
        res = await WooProductApi().getProducts(
            page: '1',
            per_page: '20',
            search: test
        );
      }

      searchResults = [];
      res.forEach((e) {
        List<WooAttributes> sizes = [];
        List<WooAttributes> colors = [];
        List<String> images = [];

        if(e.attributes != null){
          e.attributes.forEach((element) {
            if(element.name == 'Sizes'){
              sizes.add(element);
            }
            if(element.name == 'Colors'){
              colors.add(element);
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
