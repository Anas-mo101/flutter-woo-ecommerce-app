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
  List<WooShippingMethods> shippingMethods = [];
  int selectedShippingMethods = 0;

  List<WooStates> countryState = [];
  int selectedCountryState = 0;


  final cusName = TextEditingController();
  final cusEmail = TextEditingController();
  final cusPhone = TextEditingController();
  final cusBilling = TextEditingController();
  final cusShipping = TextEditingController();
  final cusZip = TextEditingController();

  bool cusNameErr = false;
  bool cusEmailErr = false;
  bool cusPhoneErr = false;
  bool cusBillingErr = false;
  bool cusShippingErr = false;
  bool cusZipErr = false;
  bool cusCountryErr = false;

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

  void initShippingZones() async {
    try{
      shippingOptions = await OrderRequirementApi().getShippingZones();
    } catch (e){
      shippingOptions = [];
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

  submitBillingInfo(){
    if(cartItems.isNotEmpty && validateCustomerInfo()){
      Billing billing = Billing(
        firstName: cusName.value.text,
        address1: cusBilling.value.text,
        address2: cusShipping.value.text,
        email: cusEmail.value.text,
        phone: cusPhone.value.text,
        country: shippingOptions[selectedShippingOptions].name,
        postcode: cusZip.value.text,
      );

      // Shipping shipping = Shipping(
      //   firstName: cusName.value.text,
      //   address1: cusShipping.value.text,
      //   country: shippingOptions[selectedShippingOptions].name,
      //   postcode: cusZip.value.text,
      // );

      ShippingLines shippingLines = ShippingLines(
        methodId: shippingMethods[selectedShippingMethods].instanceId.toString(),
        methodTitle: shippingMethods[selectedShippingMethods].title,
        total: '10.0'
      );

      WooOrder order = WooOrder(
        paymentMethod: paymentOptions[selectedPaymentOptions].id,
        paymentMethodTitle: paymentOptions[selectedPaymentOptions].title,
        setPaid: false,
        // shipping: shipping,
        billing: billing,
        lineItems: cartItems.map((e) => LineItems(
            productId: e.productId,
            quantity: e.quantity,
            variationId: e.variationId
        )).toList(),
        shippingLines: [
          shippingLines
        ]
      );

      Get.toNamed(Routes.checkout, arguments: [order, cartItems]);
    }
  }

  togglePaymentOption(String option){
    final opt = paymentOptions.indexWhere((element) => element.title == option);
    selectedPaymentOptions = opt == -1 ? 0 : opt;
    update();
  }

  toggleShippingOption(String option) async {
    final opt = shippingOptions.indexWhere((element) => element.name == option);
    selectedShippingOptions = opt == -1 ? 0 : opt;

    isLoading = true;
    update();

    await initCountryInfo();
    await initShippingMethod();

    isLoading = false;
    update();
  }

  toggleShippingMethods(String option){
    final opt = shippingMethods.indexWhere((element) => element.title == option);
    selectedShippingMethods = opt == -1 ? 0 : opt;
    update();
  }

  toggleCountryStates(String option){
    final opt = countryState.indexWhere((element) => element.name == option);
    selectedCountryState = opt == -1 ? 0 : opt;
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
