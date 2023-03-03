import 'package:get/get.dart';
import '../../product/api/woo_product_api.dart';
import '../../product/model/product.dart';
import '../../product/model/woocommerce_product.dart';
import '../model/woo_user_orders.dart';

class OrderController extends GetxController {

  bool isLoading = true;
  WooUserOrder order;
  List<Product> orderProduct = [];

  @override
  void onInit() {
    var orderRes = Get.arguments;
    print('Order response:');
    print(orderRes);
    if(orderRes is Map<String, dynamic>){
      order = WooUserOrder.fromJson(orderRes);
      init();
    }
    super.onInit();
  }

  void init() async {
    await _setOrderProducts();

    isLoading = false;
    await update();
  }

  void _setOrderProducts() async {
    try{
      List<int> ids = order.lineItems.map((e) => e.productId).toList();

      List<WooCommerceProduct> res = await WooProductApi().getProducts(
          page: '1',
          per_page: ids.length.toString(),
          include: ids.join(',')
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

        orderProduct.add(Product(
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
      print('setOrderProducts: ${e}');
      isLoading = false;
    }
    update();
  }


}
