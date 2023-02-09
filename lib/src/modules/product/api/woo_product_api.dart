import '../../../api/endpoint.dart';
import '../../../api/data providers/base_api.dart';
import '../model/woo_product_variation.dart';
import '../model/woocommerce_product.dart';


class WooProductApi extends BaseApi{


  Future<WooCommerceProduct> getProduct(int id) async {
    try{
      String product = EndPoints.wooProduct('$id');
      var response = await BaseApi().get(product, mHeader: {
        "Authorization": basicAuth
      });
      return WooCommerceProduct.fromJson(response);
    }catch(e){
      print('ProductApi getProduct(id) failed');
      throw Exception();
    }
  }

  Future<List<WooProductVariation>> getProductVars(int id) async {
    try{
      String product = EndPoints.wooProductVars('$id');
      var response = await BaseApi().get(product, mHeader: {
        "Authorization": basicAuth
      });
      return response.map<WooProductVariation>((e) => WooProductVariation.fromJson(e)).toList();
    }catch(e){
      print('ProductApi getProduct(id) failed');
      throw Exception();
    }
  }

  Future<List<WooCommerceProduct>> getProducts
      ({String search, String minPrice, String maxPrice, String page, String per_page, String category}) async{
    try{
      String productsURL = EndPoints.wooProducts(
          search: search,
          minPrice: minPrice,
          maxPrice: maxPrice,
          page: page,
          per_page: per_page,
          category: category
      );
      var response = await BaseApi().get(productsURL, mHeader: {
        "Authorization": basicAuth
      });
      return response.map<WooCommerceProduct>((e) => WooCommerceProduct.fromJson(e)).toList();
    }catch(e){
      print('ProductApi getProducts(id) failed : $e');
      throw Exception();
    }
  }

  Future<List<Categories>> getWooCategories() async{
    try{
      String productsURL = EndPoints.wooCategories();
      var response = await BaseApi().get(productsURL, mHeader: {
        "Authorization": basicAuth
      });
      return response.map<Categories>((e) => Categories.fromJson(e)).toList();
    }catch(e){
      print('ProductApi getProducts(id) failed : $e');
      throw Exception();
    }
  }
}