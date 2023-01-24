import 'package:get/get.dart';
import '../api/product_api.dart';
import '../../cart/controller/cart_controller.dart';
import '../model/product.dart';
import '../model/test_product_model.dart';


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
      TestProduct test = await getProduct(id);
      product = Product(
          id: test.id,
          name: test.title,
          image: test.images ?? [],
          price: test.price.toDouble(),
          category: '...',
          desc: test.description,
          rating: 4,
          availableSizes: [],
          availableSColor: []
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


  Future<TestProduct> getProduct(int id) async {
    try{
      return await ProductApi.getProduct(id);
    }catch(e){
      return TestProduct(
          id: id,
          title: 'Try Again Later',
          price: 0,
          description: "...",
          images: [],
      );
    }
  }
}