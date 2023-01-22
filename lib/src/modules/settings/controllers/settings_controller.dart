import 'dart:convert';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_ecommerce_app/src/modules/product/model/product.dart';

// store cart item in set() -> uniquely
// keep track of each cart item's qty in may and id as key

class SettingsController extends GetxController {

  List<String> language = ['عربي','English'];
  int selectedLanguage = 0;

  @override
  void onInit() {
    // TODO: implement onInit
    if(Get.locale.toString() == 'en_US'){
      selectedLanguage = 1;
    } else if(Get.locale.toString() == 'ar_Ar'){
      selectedLanguage = 0;
    }

    super.onInit();
  }



  void toggleLanguage(String newLang){
    final opt = language.indexOf(newLang);
    selectedLanguage = opt == -1 ? 0 : opt;

    if(opt == 0){
      Get.updateLocale(Locale('ar', 'AR'));
    }else if (opt == 1){
      Get.updateLocale(Locale('en', 'US'));
    }

    update();
  }

}
