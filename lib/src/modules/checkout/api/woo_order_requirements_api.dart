import 'dart:convert';

import '../../../api/endpoint.dart';
import '../../../api/data providers/base_api.dart';
import '../models/order_totals.dart';
import '../models/woo_country_info.dart';
import '../models/woo_order.dart';
import '../models/woo_payment_gateway.dart';
import '../models/woo_shipping_methods.dart';
import '../models/woo_shipping_zone.dart';

class OrderRequirementApi extends BaseApi{

  Future<OrderTotals> getTotals(WooOrder order) async {
    try{
      String endpoint = EndPoints.orderTotals();
      print(jsonEncode(order.toJson()));
      var response = await BaseApi().post(endpoint,jsonEncode(order.toJson()));
      return OrderTotals.fromJson(response);
    }catch(e){
      print('OrderRequirementApi getTotals() failed: ${e}');
      throw Exception();
    }
  }

  Future<List<WooStates>> getCountryInfo(String zone) async {
    try{
      String endpoint = EndPoints.wooCountryInfo(zone);
      var response = await BaseApi().get(endpoint, mHeader: {
        "Authorization": basicAuth
      });
      return response['states'].map<WooStates>((e) => WooStates.fromJson(e)).toList();
    }catch(e){
      print('OrderRequirementApi getShippingMethods() failed: ${e}');
      throw Exception();
    }
  }

  Future<List<WooShippingMethods>> getShippingMethods(int zoneID) async {
    try{
      String endpoint = EndPoints.wooShippingMethods(zoneID.toString());
      var response = await BaseApi().get(endpoint, mHeader: {
        "Authorization": basicAuth
      });
      return response.map<WooShippingMethods>((e) => WooShippingMethods.fromJson(e)).toList();
    }catch(e){
      print('OrderRequirementApi getShippingMethods() failed: ${e}');
      throw Exception();
    }
  }

  Future<List<WooPaymentGateway>> getPaymentGateways() async {
    try{
      String endpoint = EndPoints.wooPaymentGateways();
      var response = await BaseApi().get(endpoint, mHeader: {
        "Authorization": basicAuth
      });
      List<WooPaymentGateway> payments = response.map<WooPaymentGateway>((e) => WooPaymentGateway.fromJson(e)).toList();
      payments.removeWhere((element) => element.enabled == false);
      return payments;
    }catch(e){
      print('OrderRequirementApi getPaymentGateways() failed: ${e}');
      throw Exception();
    }
  }

  Future<List<WooShippingZone>> getShippingZones() async {
    try{
      String endpoint = EndPoints.wooShippingZone();
      var response = await BaseApi().get(endpoint, mHeader: {
        "Authorization": basicAuth
      });
      List<WooShippingZone> payments = response.map<WooShippingZone>((e) => WooShippingZone.fromJson(e)).toList();
      payments.removeWhere((element) => element.name == 'Locations not covered by your other zones');
      return payments;
    }catch(e){
      print('OrderRequirementApi getPaymentGateways() failed: ${e}');
      throw Exception();
    }
  }

}