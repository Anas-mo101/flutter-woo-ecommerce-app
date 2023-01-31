import 'package:get/get.dart';
import '../../cart/controller/cart_controller.dart';
import '../api/woo_product_api.dart';
import '../model/product.dart';
import '../model/woocommerce_product.dart';


class ProductController extends GetxController  {

  bool isLoading = true;

  int productId;
  int productQtyInCart = 0;
  Product product;
  WooCommerceProduct _products;
  bool isLiked = true;

  int selectedAvailableSizes = 0;
  int selectedAvailableColor = 0;
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

  void addCurrentProductToCart(){
    int selectedSizeId = _products.attributes[selectedAvailableSizes].id;
    int selectedColorId = _products.attributes[selectedAvailableColor].id;

    CartController.addToCart(product).then((value) => setProductQtyInCart());
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
        selectedAvailableColor = element.key;
      }
    }
    update();
  }

  void setProduct(int id) async {
    try{
      productId = id;
      /// Connect API Model to View Model
      _products = await getProduct(id);

      List<String> sizes = [];
      List<String> colors = [];
      List<String> images = [];

      if(_products.attributes != null){
        _products.attributes.forEach((element) {
          print(element.name);
          if(element.name == 'Size'){
            sizes.addAll(element.options);
          }
          if(element.name == 'Color'){
            colors.addAll(element.options);
          }
        });
      }

      if(_products.images != null){
        _products.images.forEach((element) {
          images.add(element.src);
        });
      }

      print('sizes: ${sizes.length}');
      print('colors: ${colors.length}');
      print('images: ${images.length}');

      product = Product(
          id: _products.id,
          name: _products.name,
          image: images,
          price: double.parse(_products.price),
          category: _products.categories != null ? _products.categories.first.name : '',
          desc: _products.description,
          rating: _products.ratingCount,
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
    if(productId == null) return;
    productQtyInCart = await CartController.getQtyFromCart(productId);
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