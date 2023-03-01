import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/route.dart';
import '../../cart/model/cart_model.dart';
import '../api/woo_order_requirements_api.dart';
import '../models/order.dart';
import '../models/woo_country_info.dart';
import '../models/woo_order.dart';
import '../models/woo_payment_gateway.dart';
import '../models/woo_shipping_methods.dart';
import '../models/woo_shipping_zone.dart';
import '../utils/countries_code.dart';

class BillingController extends GetxController {

  Order ongoingOrder;

  List<WooPaymentGateway> paymentOptions = [];
  int selectedPaymentOptions = 0;

  List<WooShippingZone> shippingOptions = [];
  int selectedShippingOptions = 0;
  List<ShippingLines> shippingMethods = [];
  int selectedShippingMethods = 0;

  List<WooStates> countryState = [];
  int selectedCountryState = 0;

  ///
  List<WooShippingZone> shippingOptions2 = [];
  int selectedShippingOptions2 = 0;
  List<ShippingLines> shippingMethods2 = [];
  int selectedShippingMethods2 = 0;

  List<WooStates> countryState2 = [];
  int selectedCountryState2 = 0;

  final cusBilling2 = TextEditingController();
  final cusShipping2 = TextEditingController();
  final cusZip2 = TextEditingController();
  final cusCity2 = TextEditingController();

  bool cusBillingErr2 = false;
  bool cusShippingErr2 = false;
  bool cusZipErr2 = false;
  bool cusCountryErr2 = false;
  bool cusCityErr2 = false;
  bool cusStateErr2 = false;

  ///


  final cusName = TextEditingController();
  final cusEmail = TextEditingController();
  final cusPhone = TextEditingController();

  final cusBilling = TextEditingController();
  final cusShipping = TextEditingController();
  final cusZip = TextEditingController();
  final cusCity = TextEditingController();

  bool cusNameErr = false;
  bool cusEmailErr = false;
  bool cusPhoneErr = false;
  bool cusBillingErr = false;
  bool cusShippingErr = false;
  bool cusZipErr = false;
  bool cusCountryErr = false;
  bool cusCityErr = false;
  bool cusStateErr = false;

  bool shipToDifferentAddress = false;

  List<CartModel> cartItems = [];

  bool isLoading = true;

  @override
  void onInit() {
    var args = Get.arguments;
    if(args is List<CartModel>){
      cartItems = args;
      _init();
    }
    super.onInit();
  }

  Future _init() async {
    await initShippingZones();
    await initPaymentMethod();
    await initShippingMethod();
    await initCountryInfo();
    isLoading = false;
    update();
  }

  void initPaymentMethod() async {
    try{
      paymentOptions = await OrderRequirementApi().getPaymentGateways();
    } catch (e){
      paymentOptions = [];
    }
  }


  void initShippingZones() async {
    try{
      shippingOptions = await OrderRequirementApi().getShippingZones();
      shippingOptions2 = shippingOptions;
    } catch (e){
      shippingOptions = [];
      shippingOptions2 = [];
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

  ///

  void initShippingMethod2() async {
    try{
      if(shippingOptions.isNotEmpty){
        shippingMethods2 = await OrderRequirementApi()
            .getShippingMethods(shippingOptions[selectedShippingOptions2].id);
      }
    } catch (e){
      shippingMethods2 = [];
    }
  }

  void initCountryInfo2() async {
    try{
      if(shippingOptions.isNotEmpty){
        var code = countryCode(shippingOptions2[selectedShippingOptions2].name) ;
        countryState2 = await OrderRequirementApi().getCountryInfo(code);
      }
    } catch (e){
      countryState2 = [];
    }
  }

  toggleShippingToDifferentAddress() async {
    shipToDifferentAddress = !shipToDifferentAddress;
    if(shipToDifferentAddress){
      if(countryState2.isEmpty){
        countryState2 = countryState;
      }
      if(shippingMethods2.isEmpty){
        shippingMethods2 = shippingMethods;
      }
    }
    update();
  }

  ///

  submitBillingInfo(){
    if(cartItems.isNotEmpty && validateCustomerInfo()){
      Billing billing = Billing(
        firstName: cusName.value.text,
        address1: cusBilling.value.text,
        address2: cusShipping.value.text,
        email: cusEmail.value.text,
        phone: cusPhone.value.text,
        country: shippingOptions[selectedShippingOptions].name,
        state: countryState[selectedCountryState].name,
        city: cusCity.value.text,
        postcode: cusZip.value.text,
      );

      Shipping shipping = Shipping(
        firstName: cusName.value.text,
        address1: cusBilling2.value.text,
        address2: cusShipping2.value.text,
        country: shipToDifferentAddress ? shippingOptions2[selectedShippingOptions2].name : '',
        state: shipToDifferentAddress ? countryState2[selectedCountryState2].name : '',
        city: cusCity2.value.text,
        postcode: cusZip2.value.text,
      );

      ShippingLines shippingLines = ShippingLines(
        methodId: shippingMethods[selectedShippingMethods].methodId,
        methodTitle: shippingMethods[selectedShippingMethods].methodTitle,
        total: shippingMethods[selectedShippingMethods].total,
      );

      WooOrder order = WooOrder(
        paymentMethod: paymentOptions[selectedPaymentOptions].id,
        paymentMethodTitle: paymentOptions[selectedPaymentOptions].title,
        setPaid: false,
        billing: billing,
        lineItems: cartItems.map((e) => LineItems(
            productId: e.productId,
            quantity: e.quantity,
            variationId: e.variationId
        )).toList(),
        shipping: shipToDifferentAddress ? shipping : null,
        shippingLines: [
          shippingLines
        ]
      );

      Get.toNamed(Routes.checkout, arguments: [order.toJson(), cartItems]);
    }
  }

  togglePaymentOption(String option){
    final opt = paymentOptions.indexWhere((element) => element.title == option);
    selectedPaymentOptions = opt == -1 ? 0 : opt;
    update();
  }

  toggleShippingOption(String option, {bool flag = true}) async {
    isLoading = true;
    update();

    if(flag){
      final opt = shippingOptions.indexWhere((element) => element.name == option);
      selectedShippingOptions = opt == -1 ? 0 : opt;

      await initCountryInfo();
      if(!shipToDifferentAddress){
        await initShippingMethod();
      }
    }else{
      final opt = shippingOptions2.indexWhere((element) => element.name == option);
      selectedShippingOptions2 = opt == -1 ? 0 : opt;

      await initCountryInfo2();
      await initShippingMethod2();
    }

    isLoading = false;
    update();
  }

  toggleShippingMethods(String option){
    final opt = shippingMethods.indexWhere((element) => element.methodTitle == option);
    selectedShippingMethods = opt == -1 ? 0 : opt;
    update();
  }

  toggleCountryStates(String option, {bool flag = true}){
    if(flag){
      final opt = countryState.indexWhere((element) => element.name == option);
      selectedCountryState = opt == -1 ? 0 : opt;
    }else{
      final opt = countryState2.indexWhere((element) => element.name == option);
      selectedCountryState2 = opt == -1 ? 0 : opt;
    }
    update();
  }

  bool validateCustomerInfo(){

    /// Validate Name
    // if(cusName.value.text.isEmpty){
    //   print(1);
    //   resetError();
    //   cusNameErr = true;
    //   update();
    //   return false;
    // }
    //
    // /// Validate Email
    // if(cusEmail.value.text.isEmpty || !isEmail(cusEmail.value.text)){
    //   print(2);
    //
    //   resetError();
    //   cusEmailErr = true;
    //   update();
    //   return false;
    // }
    //
    // /// Validate Phone
    // // if(cusPhone.value.text.isEmpty || !isPhoneNumber(cusPhone.value.text)){
    // //   print(3);
    // //
    // //   resetError();
    // //   cusPhoneErr = true;
    // //   update();
    // //   return false;
    // // }
    //
    // if(cusBilling.value.text.isEmpty){
    //   print(5);
    //
    //   resetError();
    //   cusBillingErr = true;
    //   update();
    //   return false;
    // }

    // if(selectedShippingOptions){
    //   resetError();
    //   cusCountryErr = true;
    //   update();
    //   return false;
    // }

    // /// Validate Billing
    // if(cusShipping.value.text.isEmpty){
    //   print(4);
    //
    //   resetError();
    //   cusShippingErr = true;
    //   update();
    //   return false;
    // }
    //
    // /// Validate Billing
    // if(cusCity.value.text.isEmpty){
    //   print(4);
    //
    //   resetError();
    //   cusCityErr = true;
    //   update();
    //   return false;
    // }
    //
    // if(cusZip.value.text.isEmpty || !isZipCode(cusZip.value.text)){
    //   print(6);
    //
    //   cusZipErr = true;
    //   update();
    //   return false;
    // }

    resetError();
    update();
    return true;
  }

  resetError(){
    cusNameErr = false;
    cusEmailErr = false;
    cusPhoneErr = false;
    cusBillingErr = false;
    cusShippingErr = false;
    cusZipErr = false;
    cusCityErr = false;
    cusStateErr = false;
  }

  bool isPhoneNumber(String phone) {
    String p = "^(?:[+0]9)?[0-9]{10}\$";
    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(phone);
  }

  bool isEmail(String email) {
    String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";
    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(email);
  }

  bool isZipCode(String zip) {
    String p = "^[0-9]{5}(?:-[0-9]{4})?\$";
    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(zip);
  }
}
