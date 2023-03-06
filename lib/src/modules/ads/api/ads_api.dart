import 'package:flutter_ecommerce_app/src/api/data%20providers/base_api.dart';
import 'package:flutter_ecommerce_app/src/api/endpoint.dart';
import '../model/ad_model.dart';
import '../model/ad_setting_model.dart';


class AdsApi extends BaseApi {

  Future<List<Ads>> getAllAds() async {
    try{
      var endpoint = EndPoints.allAds();
      var response = await BaseApi().get(endpoint, mHeader: BaseApi.headers);
      return response.map<Ads>((e) => Ads.fromJson(e)).toList();
    }catch(e){
      print('AdsApi getAllAds() failed: ${e}');
      throw Exception();
    }
  }

  Future<Ads> getAds() async {
    try{
      var endpoint = EndPoints.ads();
      var response = await BaseApi().get(endpoint, mHeader: BaseApi.headers);
      return Ads.fromJson(response);
    }catch(e){
      print('AdsApi getAds() failed: ${e}');
      throw Exception();
    }
  }

  Future<AdsSettings> getAdsSettings() async {
    try{
      var endpoint = EndPoints.adsSettings();
      var response = await BaseApi().get(endpoint, mHeader: BaseApi.headers);
      return AdsSettings.fromJson(response);
    }catch(e){
      print('AdsApi getAdsSettings() failed: ${e}');
      throw Exception();
    }
  }
}