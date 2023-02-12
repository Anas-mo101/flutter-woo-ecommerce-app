import 'package:flutter_ecommerce_app/src/model/woo_currency.dart';
import 'package:flutter_ecommerce_app/src/model/woo_product_tax.dart';
import 'package:get/get.dart';
import '../api/data providers/base_api.dart';
import '../api/endpoint.dart';


class WooStoreService extends GetxService {
  List<WooTax> storeTax = [];
  WooCurrency storeCurrency;

  Future<WooStoreService> init() async {

    try{
      storeCurrency = await WooStoreApi().getStoreCurrency();
    }catch(e){
      storeCurrency = WooCurrency(code: '??', name: '??', symbol: '??');
    }

    try{
      storeTax = await WooStoreApi().getStoreTax();
    }catch(e){
      storeTax = [];
    }

    return this;
  }

}


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
