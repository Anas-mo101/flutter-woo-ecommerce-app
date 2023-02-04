import 'package:flutter_ecommerce_app/src/modules/product/model/product.dart';
import 'package:get/get.dart';
import '../../product/api/woo_product_api.dart';
import '../../product/model/woocommerce_product.dart';
import '../../../model/category.dart';

class HomeController extends GetxController {

  bool isLoading = true;
  List<Product> products = [];

  // Category bar
  List<Category> categoryList = [];


  void onInit() {
    getHomeProducts();
    super.onInit();
  }


  void getHomeProducts() async {
    try{
      List<WooCommerceProduct> res = await WooProductApi().getProducts(
        page: '1',
        per_page: '20'
      );

      print('Products => ${res.length}');

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

        products.add(Product(
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
      print('getHomeProducts: ${e}');
      isLoading = false;
    }
    update();
  }
}
