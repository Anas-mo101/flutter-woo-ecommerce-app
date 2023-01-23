import 'package:flutter_ecommerce_app/src/modules/product/model/product.dart';
import 'package:get/get.dart';
import '../../../model/data.dart';
import '../../product/api/product_api.dart';
import '../../product/model/test_product_model.dart';

class HomeController extends GetxController {

  bool isLoading = true;
  List<Product> products = [];

  // Category bar
  List categoryList = AppData.categoryList;

  void toggleCategoryOptions(dynamic model) {
    categoryList.forEach((element) {
      element.isSelected = false;
    });
    model.isSelected = true;
    update();
  }

  void onInit() {
    getHomeProducts();
    super.onInit();
  }

  void getHomeProducts() async {
    try{
      List<TestProduct> res = await ProductApi.getProducts(
        offset: '0',
        limit: '20'
      );

      res.forEach((e) {
        products.add(Product(
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
