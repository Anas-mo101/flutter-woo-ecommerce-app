import 'dart:convert';

import '../../../api/endpoint.dart';
import '../../../api/data providers/base_api.dart';
import '../model/woocommerce_product.dart';


class WooProductApi extends BaseApi{
  String client = 'ck_2dc9ec0fac0a8d2d3abe0a5c6d60aaa2cf0f458e';
  String secret = 'cs_ef4ce0ed19140f49e9960f877b718e983c5e77df';
  static String basicAuth;

  WooProductApi(){
    basicAuth = 'Basic ' + base64.encode(utf8.encode('$client:$secret'));
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

  Future<List<WooCommerceProduct>> getProducts
      ({String search, String minPrice, String maxPrice, String page, String per_page}) async{
    try{
      String productsURL = EndPoints.wooProducts(
          search: search,
          minPrice: minPrice,
          maxPrice: maxPrice,
          page: page,
          per_page: per_page
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
}