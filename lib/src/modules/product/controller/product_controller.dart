import 'package:get/get.dart';
import '../../cart/controller/cart_controller.dart';
import '../api/woo_product_api.dart';
import '../model/product.dart';
import '../model/woo_product_review.dart';
import '../model/woo_product_variation.dart';
import '../model/woocommerce_product.dart';


class ProductController extends GetxController  {

  bool isLoading = true;
  bool isReviewsLoading = true;
  bool isRelatedProductsLoading = true;

  int productId;
  int productQtyInCart = 0;
  Product product;
  List<Product> relatedProducts = [];
  WooCommerceProduct _products;
  bool isLiked = true;

  List<WooProductVariation> productVars;
  bool colorFlag = false;
  bool sizeFlag = false;

  int selectedAvailableSizes = 0;
  int selectedAvailableColor = 0;
  int selectProductVariation = 0;

  List<WooProductReview> productReviews = [];

  @override
  void onInit() {
    if(Get.arguments is int){
      setProduct(Get.arguments);
    }
    super.onInit();
  }

  @override
  void onReady() {
    setProductQtyInCart();
    super.onReady();
  }

  Future<void> addCurrentProductToCart() async {
    if(_products.attributes.isNotEmpty){
      WooAttributes sizeOptions;
      WooAttributes colorOptions;
      List<String> toMatchAgainst = [];

      if(sizeFlag) {
        sizeOptions = product.availableSizes.first;
        toMatchAgainst.add(sizeOptions.options[selectedAvailableSizes]);
      }

      if(colorFlag) {
        colorOptions = product.availableSColor.first;
        toMatchAgainst.add(colorOptions.options[selectedAvailableColor]);
      }
      /// check if this element has combination of attributes
      /// same as combination picked by user
      /// if it matches then break and pass id
      /// else look in next
      print(toMatchAgainst);
      print('==================');
      productVars.forEach((element) {
        var id = element.id;
        var varCombinations = element.attributes.map((e) => e.option).toList();
        if(areListsEqual(toMatchAgainst,varCombinations)){
          CartController.addToCart(
              product, variantId: id, selectedVariations: varCombinations
          ).then((value) => setProductQtyInCart());
        }
      });
    }else{
      CartController.addToCart(product).then((value) => setProductQtyInCart());
    }
  }

  bool areListsEqual(List listA, List listB) {
    // check if both are lists
    if(listA.length != listB.length) return false;

    // check if elements are equal
    for(int i=0;i<listA.length;i++) {
      var compareAgainst = listA[i];
      bool flag = false;
      for(int x=0;x<listB.length;x++) {
        if(compareAgainst == listB[x]){
          flag = true;
        }
      }
      if(flag == false) return false;
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


  void setRelatedProducts() async {
    try{
      List<WooCommerceProduct> res = await WooProductApi().getProducts(
        page: '1',
        per_page: _products.relatedIds.length.toString(),
        include: _products.relatedIds.join(',')
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

        relatedProducts.add(Product(
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

      isRelatedProductsLoading = false;
    }catch(e){
      print('getHomeProducts: ${e}');
      isRelatedProductsLoading = false;
    }
    update();
  }

  void setProductReviews() async {
    try{
      productReviews = await getProductReviews(productId);
      isReviewsLoading = false;
    }catch(e){
      isReviewsLoading = false;
    }
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
      setProductReviews();
      setRelatedProducts();
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


  String getDurationAgo(String dateCreated) {
    Duration duration = DateTime.now().difference(DateTime.parse(dateCreated));

    if (duration.inSeconds <= 0) {
      return "Just now";
    } else if (duration.inSeconds < 60) {
      return "${duration.inSeconds} seconds ago";
    } else if (duration.inMinutes < 60) {
      return "${duration.inMinutes} minutes ago";
    } else if (duration.inHours < 24) {
      return "${duration.inHours} hours ago";
    } else if (duration.inDays < 30) {
      return "${duration.inDays} days ago";
    } else if (duration.inDays < 365) {
      return "${(duration.inDays / 30).round()} months ago";
    } else {
      return "${(duration.inDays / 365).round()} years ago";
    }
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

  Future<List<WooProductReview>> getProductReviews(int id) async {
    try{
      return await WooProductApi().getProductReviews(id);
    }catch(e){
      return [];
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