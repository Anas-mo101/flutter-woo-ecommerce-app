import '../../../api/endpoint.dart';
import '../../../api/data providers/base_api.dart';
import '../models/woo_payment_gateway.dart';
import '../models/woo_shipping_zone.dart';

class OrderRequirementApi extends BaseApi{

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