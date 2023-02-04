import 'package:get/get.dart';
import '../../cart/controller/cart_controller.dart';
import '../api/woo_product_api.dart';
import '../model/product.dart';
import '../model/woo_product_variation.dart';
import '../model/woocommerce_product.dart';


class ProductController extends GetxController  {

  bool isLoading = true;

  int productId;
  int productQtyInCart = 0;
  Product product;
  WooCommerceProduct _products;
  bool isLiked = true;

  List<WooProductVariation> productVars;
  bool colorFlag = false;
  bool sizeFlag = false;

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

  Future<void> addCurrentProductToCart() async {
    if(_products.attributes.isNotEmpty){
      WooAttributes sizeOptions;
      WooAttributes colorOptions;
      List<String> toMatchAgainst = [];

      if(colorFlag) {
        colorOptions = product.availableSColor.first;
        toMatchAgainst.add(colorOptions.options[selectedAvailableColor]);
      }

      if(sizeFlag) {
        sizeOptions = product.availableSizes.first;
        toMatchAgainst.add(sizeOptions.options[selectedAvailableSizes]);
      }
      /// check if this element has combination of attributes
      /// same as combination picked by user
      /// if it matches then break and pass id
      /// else look in next
      print(toMatchAgainst);
      productVars.forEach((element) {
        var id = element.id;
        var varCombinations = element.attributes.map((e) => e.option).toList();
        print(varCombinations);
        if(areListsEqual(toMatchAgainst,varCombinations)){
          CartController.addToCart(product, variantId: id)
              .then((value) => setProductQtyInCart());
        }
      });
    }else{
      CartController.addToCart(product).then((value) => setProductQtyInCart());
    }
  }

  bool areListsEqual(var list1, var list2) {
    // check if both are lists
    if(!(list1 is List && list2 is List)
        // check if both have same length
        || list1.length!=list2.length) {
      return false;
    }

    // check if elements are equal
    for(int i=0;i<list1.length;i++) {
      if(list1[i]!=list2[i]) {
        return false;
      }
    }

    return true;
  }

  void toggleProduct(int index) {
    selectProductVariation = index;
    update();
  }

  void toggleSizeOptions(String selected) {
    product.availableSizes.forEach((e) {
      for (var element in e.options.asMap().entries) {
        if (selected == element.value) {
          selectedAvailableSizes = element.key;
        }
      }
    });

    update();
  }

  void toggleColorOptions(String selected) {
    product.availableSColor.forEach((e) {
      for (var element in e.options.asMap().entries) {
        if (selected == element.value) {
          selectedAvailableColor = element.key;
        }
      }
    });
    update();
  }

  void setProduct(int id) async {
    try{
      productId = id;
      /// Connect API Model to View Model
      _products = await getProduct(id);

      List<WooAttributes> sizes = [];
      List<WooAttributes> colors = [];
      List<String> images = [];
      if(_products.attributes != null){
        _products.attributes.forEach((element) {
          if(element.name == 'Size'){
            sizeFlag = true;
            sizes.add(element);
          }
          if(element.name == 'Color'){
            colorFlag = true;
            colors.add(element);
          }
        });
      }

      if(_products.images != null){
        _products.images.forEach((element) {
          images.add(element.src);
        });
      }

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

      getProductVars(_products.id);

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


  Future<void> getProductVars(int id) async {
    try{
      productVars = await WooProductApi().getProductVars(id);
    }catch(e){
      productVars = [];
    }
  }


}