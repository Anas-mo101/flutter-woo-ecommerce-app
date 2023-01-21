import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/modules/product/model/product.dart';
import 'package:flutter_ecommerce_app/src/themes/light_color.dart';
import 'package:flutter_ecommerce_app/src/themes/theme.dart';
import 'package:flutter_ecommerce_app/src/widgets/extentions.dart';
import 'package:flutter_ecommerce_app/src/widgets/title_text.dart';
import 'package:get/get.dart';
import '../../../config/route.dart';
import '../../../widgets/bottom_navigation_bar.dart';
import '../../../widgets/topbar.dart';
import '../../cart/controller/cart_controller.dart';
import '../controller/checkout_controller.dart';

class TogglePaymentOptions extends StatelessWidget{
    TogglePaymentOptions({Key key}) : super(key: key);

    final checkoutController = Get.put(CheckoutController());

    Widget paymentOptions(String option){
      bool selected = checkoutController.paymentOptions.indexOf(option) == checkoutController.selectedPaymentOptions;

      return InkWell(
        onTap: () => checkoutController.togglePaymentOption(option),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                    color: selected ? LightColor.orange : Colors.grey,
                    width: 2.0,
                  )
              ),
              child: Center(child: Text(option)),
            ),
            SizedBox(height: 10),
          ],
        ),
      );
    }

    @override
    Widget build(BuildContext context) {
      return Container(
        child: Column(
          children: [
            ...checkoutController.paymentOptions.map((e) => paymentOptions(e))
          ],
        ),
      );
    }
}


class BillingPage extends StatelessWidget {
  BillingPage({Key key}) : super(key: key);

  final checkoutController = Get.put(CheckoutController());

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
          if(checkoutController.uniqueList.isNotEmpty){
            Get.toNamed(Routes.checkout, arguments: [
              checkoutController.uniqueList,
              checkoutController.itemsQty
            ]);
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
          child: GetBuilder<CheckoutController>(
              init: CheckoutController(),
              builder: (controller) {
                List args = Get.arguments ?? [];
                if(args.isEmpty){
                  Get.back();
                }
                controller.setCartItems(args[0], args[1]);

                return Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    SingleChildScrollView(
                      child: Container(
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            TopBar('Billing',Icons.arrow_back_sharp,() => Get.back()),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Shipping Information'),
                                  SizedBox(height: 20),
                                  TextField(
                                    decoration: InputDecoration(
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
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                        borderSide: BorderSide(color: Colors.blue, width: 2.0),
                                      ),
                                      hintText: "Email",
                                      hintStyle: TextStyle(fontSize: 12),
                                      contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 5),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  TextField(
                                    decoration: InputDecoration(
                                      border:  OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                        borderSide: BorderSide(color: Colors.blue, width: 2.0),
                                      ),
                                      hintText: "Phone number",
                                      hintStyle: TextStyle(fontSize: 12),
                                      contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 5),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  TextField(
                                    decoration: InputDecoration(
                                      border:  OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                        borderSide: BorderSide(color: Colors.blue, width: 2.0),
                                      ),
                                      hintText: "Billing address",
                                      hintStyle: TextStyle(fontSize: 12),
                                      contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 5),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  TextField(
                                    decoration: InputDecoration(
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
