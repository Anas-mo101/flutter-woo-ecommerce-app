import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/themes/light_color.dart';
import 'package:flutter_ecommerce_app/src/themes/theme.dart';
import 'package:flutter_ecommerce_app/src/widgets/title_text.dart';
import 'package:get/get.dart';
import '../../../config/route.dart';
import '../../../widgets/topbar.dart';
import '../controller/billing_controller.dart';
import '../widgets/toggle_payment_options.dart';

class BillingPage extends StatelessWidget {
  BillingPage({Key key}) : super(key: key);

  final billingController = Get.put(BillingController());

  Widget _submitButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(LightColor.orange),
        ),
        onPressed: () => billingController.submitBillingInfo(),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 4),
          width: AppTheme.fullWidth(context) * .75,
          child: TitleText(
            text: 'next'.tr,
            color: LightColor.background,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: GetBuilder<BillingController>(
              init: BillingController(),
              builder: (controller) {
                return Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Container(
                      height: AppTheme.fullHeight(context) - 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xfffbfbfb),
                            Color(0xfff7f7f7),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: controller.isLoading ?
                      Center(child: CircularProgressIndicator()) :
                      SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            TopBar('billing'.tr,Icons.arrow_back_sharp,() => Get.toNamed(Routes.cart), rightIcon: null),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ..._customerInfo(controller),
                                  ..._shippingInfo(controller),
                                  if(controller.shippingMethods.isNotEmpty)
                                    _shippingMethods(controller),
                                  SizedBox(height: 20),
                                  Text('payment_method'.tr),
                                  SizedBox(height: 20),
                                  TogglePaymentOptions()
                                ],
                              ),
                            ),
                            _submitButton(context),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
          )
      ),
    );
  }

  List<Widget> _shippingInfo(BillingController controller){
    return [
      Text('shipping_info'.tr),
      SizedBox(height: 20),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(
              color: controller.cusCountryErr ? Colors.red : Colors.grey,
              width: 1.0,
            )
        ),
        child: DropdownButton<String>(
          hint: Text('country'.tr, style: TextStyle(fontSize: 14)),
          value: controller.shippingOptions[controller.selectedShippingOptions].name,
          isExpanded: true,
          underline: Container(),
          borderRadius: BorderRadius.circular(15.0),
          items: [
            ...controller.shippingOptions.map((e) => DropdownMenuItem(
              child: Text(e.name),
              value: e.name,
            )),
          ],
          onChanged: (String newValue) => controller.toggleShippingOption(newValue),
        ),
      ),
      SizedBox(height: 20),
      TextField(
        controller: controller.cusShipping,
        decoration: InputDecoration(
          errorText: controller.cusShippingErr ? 'invalid_input'.tr : null,
          border:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Colors.blue, width: 2.0),
          ),
          hintText: 'Street Address 1',
          hintStyle: TextStyle(fontSize: 12),
          contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 5),
        ),
      ),
      SizedBox(height: 20),
      TextField(
        controller: controller.cusBilling,
        decoration: InputDecoration(
          errorText: controller.cusBillingErr ? 'invalid_input'.tr : null,
          border:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          hintText: 'Street Address 2 (Optional)',
          hintStyle: TextStyle(fontSize: 12),
          contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 5),
        ),
      ),
      SizedBox(height: 20),
      TextField(
        controller: controller.cusBilling,
        decoration: InputDecoration(
          errorText: controller.cusBillingErr ? 'invalid_input'.tr : null,
          border:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          hintText: 'Town / City',
          hintStyle: TextStyle(fontSize: 12),
          contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 5),
        ),
      ),
      SizedBox(height: 20),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(
              color: controller.cusCountryErr ? Colors.red : Colors.grey,
              width: 1.0,
            )
        ),
        child: DropdownButton<String>(
          hint: Text('country'.tr, style: TextStyle(fontSize: 14)),
          value: controller.countryState[controller.selectedCountryState].name,
          isExpanded: true,
          underline: Container(),
          borderRadius: BorderRadius.circular(15.0),
          items: [
            ...controller.countryState.map((e) => DropdownMenuItem(
              child: Text(e.name),
              value: e.name,
            )),
          ],
          onChanged: (String newValue) => controller.toggleCountryStates(newValue),
        ),
      ),
      SizedBox(height: 20),
      TextField(
        controller: controller.cusZip,
        decoration: InputDecoration(
          errorText: controller.cusZipErr ? 'invalid_input'.tr : null,
          border:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Colors.blue, width: 2.0),
          ),
          hintText: "zip_code".tr,
          hintStyle: TextStyle(fontSize: 12),
          contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 5),
        ),
      ),
      SizedBox(height: 20),
    ];
  }

  List<Widget> _customerInfo(BillingController controller){
    return [
      Text('customer_info'.tr),
      SizedBox(height: 20),
      TextField(
        controller: controller.cusName,
        decoration: InputDecoration(
          errorText: controller.cusNameErr ? 'invalid_input'.tr : null,
          border:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Colors.blue, width: 2.0),
          ),
          hintText: "name".tr,
          hintStyle: TextStyle(fontSize: 12),
          contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 5),
        ),
      ),
      SizedBox(height: 20),
      TextField(
        controller: controller.cusEmail,
        decoration: InputDecoration(
          errorText: controller.cusEmailErr ? 'invalid_input'.tr : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          hintText: "email".tr,
          hintStyle: TextStyle(fontSize: 12),
          contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 5),
        ),
      ),
      SizedBox(height: 20),
      TextField(
        controller: controller.cusPhone,
        decoration: InputDecoration(
          errorText: controller.cusPhoneErr ? 'invalid_input'.tr : null,
          border:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          hintText: "phone_number".tr,
          hintStyle: TextStyle(fontSize: 12),
          contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 5),
        ),
      ),

      SizedBox(height: 20),
    ];
  }

  Widget _shippingMethods(BillingController controller){
    return Column(
      children: [
        Text('Shipping Methods'),
        SizedBox(height: 20),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                color: controller.cusCountryErr ? Colors.red : Colors.grey,
                width: 1.0,
              )
          ),
          child: DropdownButton<String>(
            hint: Text('country'.tr, style: TextStyle(fontSize: 14)),
            value: controller.shippingMethods[controller.selectedShippingMethods].title,
            isExpanded: true,
            underline: Container(),
            borderRadius: BorderRadius.circular(15.0),
            items: [
              ...controller.shippingMethods.map((e) => DropdownMenuItem(
                child: Text(e.title),
                value: e.title,
              )),
            ],
            onChanged: (String newValue) => controller.toggleShippingMethods(newValue),
          ),
        ),
      ],
    );
  }


}
