import '../../../api/endpoint.dart';
import '../model/test_product_model.dart';
import '../../../api/data providers/base_api.dart';


class ProductApi extends BaseApi{

  static Future<TestProduct> getProduct(int id) async {
    try{
      String product = EndPoints.product('$id');
      var response = await BaseApi().get(product);
      return TestProduct.fromJson(response);
    }catch(e){
      print('ProductApi getProduct(id) failed');
      throw Exception();
    }
  }

  static Future<List<TestProduct>> getProducts({String search, String category, String minPrice, String maxPrice, String offset, String limit}) async{
    try{
      String productsURL = EndPoints.products(
        search: search,
        category: category,
        minPrice: minPrice,
        maxPrice: maxPrice,
        offset: offset,
        limit: limit
      );
      var response = await BaseApi().get(productsURL);
      return response.map<TestProduct>((e) => TestProduct.fromJson(e)).toList();
    }catch(e){
      print('ProductApi getProducts(id) failed : $e');
      throw Exception();
    }
  }
}