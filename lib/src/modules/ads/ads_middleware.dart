import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../config/route.dart';

class AdsService extends GetxService {
  Future<AdsService> init() async => this;

  final prefsKey = 'LastAdInterval';
  final adsInterval = Duration(minutes: 1);
  DateTime lastAdsTiming = DateTime.now();

  bool isValidAdTiming() {
    DateTime now = DateTime.now();
    print('AdsService: $lastAdsTiming');
    bool validation = now.difference(lastAdsTiming) > adsInterval;
    if(validation) lastAdsTiming = now;
    print('AdsService isValidAdTiming(): $validation');
    return validation;
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