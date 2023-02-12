import 'package:flutter_ecommerce_app/src/config/woo_store/woo_store_api.dart';
import 'package:flutter_ecommerce_app/src/model/woo_currency.dart';
import 'package:flutter_ecommerce_app/src/model/woo_product_tax.dart';
import 'package:get/get.dart';
import '../../model/woo_coupons.dart';


class WooStoreService extends GetxService {
  List<WooTax> storeTax = [];
  WooCurrency storeCurrency;
  List<WooCoupons> _coupons = [];

  Future<WooStoreService> init() async {
    await setCoupons();
    await setTax();
    await setCurrency();

    return this;
  }

  setCoupons() async {
    try{
      _coupons = await WooStoreApi().getCoupons();
    }catch(e){
      _coupons = [];
    }
  }

  setTax() async {
    try{
      storeTax = await WooStoreApi().getStoreTax();
    }catch(e){
      storeTax = [];
    }
  }

  setCurrency() async {
    try{
      storeCurrency = await WooStoreApi().getStoreCurrency();
    }catch(e){
      storeCurrency = WooCurrency(code: '??', name: '??', symbol: '??');
    }
  }

}
