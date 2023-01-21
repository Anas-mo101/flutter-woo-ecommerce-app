import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/themes/light_color.dart';
import 'package:flutter_ecommerce_app/src/themes/theme.dart';
import 'package:flutter_ecommerce_app/src/widgets/title_text.dart';
import 'package:get/get.dart';
import '../../../config/route.dart';
import '../../../widgets/topbar.dart';
import '../controller/billing_controller.dart';
import '../controller/checkout_controller.dart';
import '../models/order.dart';
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
        onPressed: () {
          if(billingController.uniqueList.isNotEmpty && billingController.validateCustomerInfo()){
            Order order = Order(
              billingController.itemsQty,
              billingController.uniqueList,
              billingController.paymentOptions[billingController.selectedPaymentOptions],
              billingController.cusName.value.text,
              billingController.cusPhone.value.text,
              billingController.cusEmail.value.text,
              billingController.cusBilling.value.text,
              billingController.cusShipping.value.text,
              billingController.cusZip.value.text,
              billingController.shippingOptions[billingController.selectedShippingOptions],
            );

            print([
              billingController.itemsQty,
              billingController.uniqueList,
              billingController.paymentOptions[billingController.selectedPaymentOptions],
              billingController.cusName.value.text,
              billingController.cusPhone.value.text,
              billingController.cusEmail.value.text,
              billingController.cusBilling.value.text,
              billingController.cusShipping.value.text,
              billingController.cusZip.value.text,
              billingController.shippingOptions[billingController.selectedShippingOptions],
            ]);

            Get.toNamed(Routes.checkout, arguments: [
              billingController.itemsQty,
              billingController.uniqueList,
              billingController.paymentOptions[billingController.selectedPaymentOptions],
              billingController.cusName.value.text,
              billingController.cusPhone.value.text,
              billingController.cusEmail.value.text,
              billingController.cusBilling.value.text,
              billingController.cusShipping.value.text,
              billingController.cusZip.value.text,
              billingController.shippingOptions[billingController.selectedShippingOptions],
            ]);
            // Get.toNamed(Routes.checkout);
          }
        },
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 4),
          width: AppTheme.fullWidth(context) * .75,
          child: TitleText(
            text: 'Next',
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
                var args = Get.arguments;
                if(!(args is List)) Get.offAndToNamed(Routes.cart);

                if(args[0] is List) controller.uniqueList = args[0];
                if(args[1] is Map) controller.itemsQty = args[1];

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
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            TopBar('Billing',Icons.arrow_back_sharp,() => Get.toNamed(Routes.cart)),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Customer Information'),
                                  SizedBox(height: 20),
                                  TextField(
                                    controller: controller.cusName,
                                    decoration: InputDecoration(
                                      errorText: controller.cusNameErr ? 'Invalid input' : null,
                                      border:  OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                        borderSide: BorderSide(color: Colors.blue, width: 2.0),
                                      ),
                                      hintText: "Customer Name",
                                      hintStyle: TextStyle(fontSize: 12),
                                      contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 5),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  TextField(
                                    controller: controller.cusEmail,
                                    decoration: InputDecoration(
                                      errorText: controller.cusEmailErr ? 'Invalid input' : null,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                      hintText: "Email",
                                      hintStyle: TextStyle(fontSize: 12),
                                      contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 5),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  TextField(
                                    controller: controller.cusPhone,
                                    decoration: InputDecoration(
                                      errorText: controller.cusPhoneErr ? 'Invalid input' : null,
                                      border:  OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                      hintText: "Phone number",
                                      hintStyle: TextStyle(fontSize: 12),
                                      contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 5),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  TextField(
                                    controller: controller.cusBilling,
                                    decoration: InputDecoration(
                                      errorText: controller.cusBillingErr ? 'Invalid input' : null,
                                      border:  OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                      hintText: "Billing address",
                                      hintStyle: TextStyle(fontSize: 12),
                                      contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 5),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Text('Shipping Information'),
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
                                      hint: Text('Country', style: TextStyle(fontSize: 14)),
                                      value: controller.shippingOptions[controller.selectedShippingOptions],
                                      isExpanded: true,
                                      underline: Container(),
                                      borderRadius: BorderRadius.circular(15.0),
                                      items: [
                                        ...controller.shippingOptions.map((e) => DropdownMenuItem(
                                          child: Text(e),
                                          value: e,
                                        )),
                                      ],
                                      onChanged: (String newValue) {
                                        controller.toggleShippingOption(newValue);
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  TextField(
                                    controller: controller.cusShipping,
                                    decoration: InputDecoration(
                                      errorText: controller.cusShippingErr ? 'Invalid input' : null,
                                      border:  OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                        borderSide: BorderSide(color: Colors.blue, width: 2.0),
                                      ),
                                      hintText: "Shipping address",
                                      hintStyle: TextStyle(fontSize: 12),
                                      contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 5),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  TextField(
                                    controller: controller.cusZip,
                                    decoration: InputDecoration(
                                      errorText: controller.cusZipErr ? 'Invalid input' : null,
                                      border:  OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                        borderSide: BorderSide(color: Colors.blue, width: 2.0),
                                      ),
                                      hintText: "Zip Code",
                                      hintStyle: TextStyle(fontSize: 12),
                                      contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 5),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Text('Payment Method'),
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
}
