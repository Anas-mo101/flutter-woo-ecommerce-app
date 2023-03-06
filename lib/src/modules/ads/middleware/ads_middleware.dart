import 'dart:collection';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../config/route.dart';
import '../api/ads_api.dart';
import '../controllers/ads_controller.dart';
import '../model/ad_model.dart';
import '../model/ad_setting_model.dart';

class AdsService extends GetxService {

  Future<AdsService> init() async {
    await setAds();
    await setAdsSettings();

    return this;
  }

  Duration adsInterval = Duration(minutes: 1);
  DateTime lastAdsTiming = DateTime.now();

  Queue<Ads> ads = Queue();
  AdsSettings adsSettings;

  bool isValidAdTiming() {
    DateTime now = DateTime.now();
    print('AdsService: $lastAdsTiming');
    bool validation = now.difference(lastAdsTiming) > adsInterval;
    if(validation) lastAdsTiming = now;
    print('AdsService isValidAdTiming(): $validation');
    return validation;
  }

  bool isAdsAvailable() {
    return true;
  }

  setAdsSettings() async {
    try{
      adsSettings = await AdsApi().getAdsSettings();

      int min = int.parse(adsSettings.interval);
      adsInterval = Duration(minutes: min);
    }catch(e){
      adsSettings = AdsSettings(interval: '1');
    }
  }

  setAds() async {
    try{
      List<Ads> _ads = [];// await AdsController.getAdsAsCache();
      if(_ads.isEmpty){
        _ads = await AdsApi().getAllAds();
        AdsController.storeAdsAsCache(_ads);
      }
      ads.addAll(_ads);
    }catch(e){
      ads = Queue();
    }
  }

  Future<Ads> getAd() async {
    try{
      if(ads.isEmpty){
        await setAds();
      }

      var first = ads.first;
      ads.remove(ads.first);

      return first;
    } catch (e){
      throw Exception();
    }
  }
}

class MidScreensAdv extends GetMiddleware {
  // Our middleware content

  @override
  RouteSettings redirect(String route) {
    return Get.find<AdsService>().isValidAdTiming() ?
      RouteSettings(name: Routes.billboard, arguments: route) : null;
  }
}