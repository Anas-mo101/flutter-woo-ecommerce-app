import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_ecommerce_app/src/modules/profile/middleware/auth_middleware.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../checkout/api/woo_order_requirements_api.dart';
import '../../checkout/models/woo_country_info.dart';
import '../../checkout/models/woo_order.dart';
import '../../checkout/models/woo_shipping_zone.dart';
import '../../checkout/utils/countries_code.dart';
import '../models/address.dart';

class AddressesController extends GetxController {

  bool isLoading = true;
  bool isCreateLoading = true;
  List<Address> addresses = [];

  String addressesKey;
  String defaultAddressesKey;
  String defaultAddresses;

  final cusAddressOne = TextEditingController();
  final cusAddressTwo = TextEditingController();
  final cusCity = TextEditingController();
  final cusZip = TextEditingController();

  List<WooShippingZone> shippingOptions = [];
  int selectedShippingOptions = 0;
  List<ShippingLines> shippingMethods = [];
  int selectedShippingMethods = 0;
  List<WooStates> countryState = [];
  int selectedCountryState = 0;

  bool cusAddressOneErr = false;
  bool cusAddressTwoErr = false;
  bool cusZipErr = false;
  bool cusCountryErr = false;
  bool cusCityErr = false;
  bool cusStateErr = false;

  @override
  void onInit() {
    final uid = Get.find<AuthService>().authedUser.id;
    addressesKey = 'ecom_app_user_${uid}_address';
    defaultAddressesKey = 'ecom_app_user_${uid}_address_default';
    init();
    super.onInit();
  }

  void init() async {
    await _loadUserAddresses();
    isLoading = false;
    await update();

    await initShippingZones();
    await initShippingMethod();
    await initCountryInfo();
    isCreateLoading = false;

    update();
  }

  Future<void> setDefault(String key) async {
    final prefs = await SharedPreferences.getInstance();
    defaultAddresses = key;
    prefs.setString(defaultAddressesKey, key);
    update();
  }

  Future<void> delete(String key) async {
    final prefs = await SharedPreferences.getInstance();
    var ad = addresses.firstWhere((element) => element.key == key);
    addresses.remove(ad);
    prefs.setStringList(addressesKey, addresses.map((item) => jsonEncode(item.toJson())).toList());
    update();
  }

  toggleShippingOption(String option) async {
    isCreateLoading = true;
    update();

    final opt = shippingOptions.indexWhere((element) => element.name == option);
    selectedShippingOptions = opt == -1 ? 0 : opt;
    await initCountryInfo();
    await initShippingMethod();

    isCreateLoading = false;
    update();
  }

  toggleCountryStates(String option){
    final opt = countryState.indexWhere((element) => element.name == option);
    selectedCountryState = opt == -1 ? 0 : opt;
    update();
  }

  void initShippingZones() async {
    try{
      shippingOptions = await OrderRequirementApi().getShippingZones();
    } catch (e){
      shippingOptions = [];
    }
  }

  void initShippingMethod() async {
    try{
      if(shippingOptions.isNotEmpty){
        shippingMethods = await OrderRequirementApi()
            .getShippingMethods(shippingOptions[selectedShippingOptions].id);
      }
    } catch (e){
      shippingMethods = [];
    }
  }

  void initCountryInfo() async {
    try{
      if(shippingOptions.isNotEmpty){
        var code = countryCode(shippingOptions[selectedShippingOptions].name) ;
        countryState = await OrderRequirementApi().getCountryInfo(code);
      }
    } catch (e){
      countryState = [];
    }
  }

  void _loadUserAddresses() async {
    try{
      final prefs = await SharedPreferences.getInstance();
      List<String> address = prefs.getStringList(addressesKey) ?? [];
      print(address);
      defaultAddresses = prefs.getString(defaultAddressesKey);
      addresses = address.map((item) => Address.fromJson(jsonDecode(item))).toList();
      isLoading = false;
    }catch(e){
      print('_loadUserAddresses: ${e}');
      isLoading = false;
    }
    update();
  }

  void createUserAddress(Address address) async {
    try{
      var ad = jsonEncode(address.toJson());
      final prefs = await SharedPreferences.getInstance();
      List<String> _addresses = prefs.getStringList(addressesKey) ?? [];
      _addresses.add(ad);
      addresses = _addresses.map((item) => Address.fromJson(jsonDecode(item))).toList();
      prefs.setStringList(addressesKey, _addresses.map((item) => item).toList());
      update();
    }catch(e){
      print('createUserAddress: ${e}');
    }
  }

  Future<void> updateAddress(String key) async {
    final prefs = await SharedPreferences.getInstance();

    addresses.forEach((element) {
      if(element.key == key){
        element = getNewAddressInfo();
        element.key = key;
      }
    });

    prefs.setStringList(addressesKey, addresses.map((item) => jsonEncode(item.toJson())).toList());
    update();
  }

  Address getNewAddressInfo(){
    // return Address(
    //   '${cusAddressOne.value.text.camelCase}_${Random().nextInt(1000).toString()}',
    //   address1: cusAddressOne.value.text,
    //   address2: cusAddressTwo.value.text ?? '',
    //   country: shippingOptions[selectedShippingOptions].name,
    //   state: countryState[selectedCountryState].name,
    //   city: cusCity.value.text,
    //   postcode: cusZip.value.text,
    // );
    return Address(
      Random().nextInt(1000).toString(),
      address1: 'cusAddressOne.value.text',
      address2: cusAddressTwo.value.text ?? '',
      country: shippingOptions[selectedShippingOptions].name,
      state: countryState[selectedCountryState].name,
      city: 'cusCity.value.text',
      postcode: 'cusZip.value.text',
    );
  }


  bool validateAddressInfo(){
    return true;

    if(cusAddressOne.value.text.isEmpty){
      print(5);

      resetError();
      cusAddressOneErr = true;
      update();
      return false;
    }

    /// Validate Billing
    if(cusCity.value.text.isEmpty){
      print(4);

      resetError();
      cusCityErr = true;
      update();
      return false;
    }

    if(cusZip.value.text.isEmpty || !isZipCode(cusZip.value.text)){
      print(6);

      cusZipErr = true;
      update();
      return false;
    }

    resetError();
    update();
    return true;
  }

  resetError(){
    cusAddressOneErr = false;
    cusAddressTwoErr = false;
    cusZipErr = false;
    cusCityErr = false;
    cusStateErr = false;
  }

  bool isZipCode(String zip) {
    String p = "^[0-9]{5}(?:-[0-9]{4})?\$";
    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(zip);
  }
}
