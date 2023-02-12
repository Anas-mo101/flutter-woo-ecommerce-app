import '../../api/data providers/base_api.dart';
import '../../api/endpoint.dart';
import '../../model/woo_coupons.dart';
import '../../model/woo_currency.dart';
import '../../model/woo_product_tax.dart';

class WooStoreApi extends BaseApi {

  Future<List<WooTax>> getStoreTax() async {
    try{
      final endpoint = EndPoints.wooStoreTax();
      var response = await get(endpoint, mHeader: {
        "Authorization": basicAuth
      });
      return response.map<WooTax>((e) => WooTax.fromJson(e)).toList();
    }catch(e){
      print('WooStoreApi getStoreTax failed');
      throw Exception();
    }
  }

  Future<List<WooCoupons>> getCoupons() async {
    try{
      final endpoint = EndPoints.wooStoreCoupons();
      var response = await get(endpoint, mHeader: {
        "Authorization": basicAuth
      });
      return response.map<WooCoupons>((e) => WooCoupons.fromJson(e)).toList();
    }catch(e){
      print('WooStoreApi getStoreTax failed');
      throw Exception();
    }
  }

  Future<WooCurrency> getStoreCurrency() async {
    try{
      final endpoint = EndPoints.wooStoreCurrency();
      var response = await get(endpoint, mHeader: {
        "Authorization": basicAuth
      });
      return WooCurrency.fromJson(response);
    }catch(e){
      print('WooStoreApi getStoreCurrency failed');
      throw Exception();
    }
  }

}