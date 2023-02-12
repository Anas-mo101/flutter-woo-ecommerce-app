import '../../../api/endpoint.dart';
import '../../../api/data providers/base_api.dart';
import '../model/woo_product_review.dart';
import '../model/woo_product_variation.dart';
import '../model/woocommerce_product.dart';


class WooProductApi extends BaseApi{

  Future<List<WooProductReview>> getProductReviews(int id, {String page = '1', String perPage = '5'}) async {
    try{
      String endpoint = EndPoints.wooProductReview('$id', page: page, perPage: perPage);
      var response = await BaseApi().get(endpoint, mHeader: {
        "Authorization": basicAuth
      });
      return response.map<WooProductReview>((e) => WooProductReview.fromJson(e)).toList();
    }catch(e){
      print('ProductApi getProductReviews(id) failed');
      throw Exception();
    }
  }

  Future<bool> createProductReview
      (int id, String review, String reviewer, String reviewerEmail, int rating) async {
    try{
      String endpoint = EndPoints.wooCreateProductReview();
      var response = await BaseApi().post(
        endpoint,
        {
          "product_id": id,
          "review": review,
          "reviewer": reviewer,
          "reviewer_email": reviewerEmail,
          "rating": rating
        },
        mHeader: {
          "Authorization": basicAuth
        }
      );
      return true;
    }catch(e){
      print('ProductApi getProductReviews(id) failed');
      return false;
    }
  }

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
      ({String search, String minPrice, String maxPrice, String page, String per_page, String category, String include}) async{
    try{
      String productsURL = EndPoints.wooProducts(
          search: search,
          minPrice: minPrice,
          maxPrice: maxPrice,
          page: page,
          per_page: per_page,
          category: category,
          include: include
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