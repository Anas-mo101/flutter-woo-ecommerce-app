import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../config/route.dart';
import '../middleware/ads_middleware.dart';
import '../model/ad_model.dart';

class AdsController extends GetxController {

  bool isLoading = true;
  Ads ads;
  String nextRoute = Routes.home;

  static String adsLocalKey = 'ecom_mobile_ads_cache';

  @override
  void onInit() {
    print('adsInfo response:');
    nextRoute = Get.arguments;
    init();
    super.onInit();
  }

  void init() async {
    await setAd();

    isLoading = false;
    await update();
  }

  Future<void> setAd() async {

    try{
      // ads = await AdsApi().getAds();
      ads = await Get.find<AdsService>().getAd();
    }catch(e){
      print('setComplain failed :$e');
      Get.offAndToNamed(nextRoute);
    }
  }

  static Future<void> storeAdsAsCache(List<Ads> adsToBeStored) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(adsLocalKey, (adsToBeStored.map((item) => jsonEncode(item)).toList()));
  }

  static Future<List<Ads>> getAdsAsCache() async {
    final prefs = await SharedPreferences.getInstance();
    var list = prefs.getStringList(adsLocalKey) ?? [];
    return list.map<Ads>((e) => Ads.fromJson(jsonDecode(e))).toList();
  }

}
