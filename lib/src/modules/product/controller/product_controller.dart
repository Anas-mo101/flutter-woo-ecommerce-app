import 'package:get/get.dart';
import '../../cart/controller/cart_controller.dart';
import '../api/woo_product_api.dart';
import '../model/product.dart';
import '../model/woocommerce_product.dart';


class ProductController extends GetxController  {

  bool isLoading = true;

  int product_id;
  int productQtyInCart = 0;
  Product product;
  bool isLiked = true;

  int selectedAvailableSizes = 0;
  int selectedAvailableSColor = 0;
  int selectProductVariation = 0;


  @override
  void onInit() {
    // TODO: implement onInit
    if(Get.arguments is int){
      setProduct(Get.arguments);
    }
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    setProductQtyInCart();
    super.onReady();
  }

  void toggleProduct(int index) {
    selectProductVariation = index;
    update();
  }

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

  void setProduct(int id) async {
    try{
      product_id = id;
      /// Connect API Model to View Model
      WooCommerceProduct products_ = await getProduct(id);

      List<String> sizes = [];
      List<String> colors = [];
      List<String> images = [];

      if(products_.attributes != null){
        products_.attributes.forEach((element) {
          if(element.name == 'Sizes'){
            sizes.addAll(element.options);
          }
          if(element.name == 'Colors'){
            colors.addAll(element.options);
          }
        });
      }

      if(products_.images != null){
        products_.images.forEach((element) {
          images.add(element.src);
        });
      }


      product = Product(
          id: products_.id,
          name: products_.name,
          image: images,
          price: double.parse(products_.price),
          category: products_.categories != null ? products_.categories.first.name : '',
          desc: products_.description,
          rating: products_.ratingCount,
          availableSizes: sizes,
          availableSColor: colors,
          isliked: true
      );

      isLoading = false;
    }catch(e){
      isLoading = false;
    }
    update();
  }

  void setProductQtyInCart() async {
    if(product_id == null) return;
    productQtyInCart = await CartController.getQtyFromCart(product_id);
    update();
  }


  Future<WooCommerceProduct> getProduct(int id) async {
    try{
      return await WooProductApi().getProduct(id);
    }catch(e){
      return WooCommerceProduct(
          id: id,
          name: 'Try Again Later',
          price: '0.0',
          description: "...",
          images: [],
      );
    }
  }
}