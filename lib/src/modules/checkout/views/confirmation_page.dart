import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/themes/light_color.dart';
import 'package:get/get.dart';
import '../../../config/route.dart';
import '../../../themes/theme.dart';
import '../../../widgets/title_text.dart';
import '../models/woo_order_response.dart';

class ConfirmationPage extends StatelessWidget {

  WooOrderResponse orderResponse;

  ConfirmationPage(){
    var orderRes = Get.arguments;
    if(orderRes is Map<String, dynamic>){
      orderResponse = WooOrderResponse.fromJson(orderRes);
      print('Order response: ${orderResponse.orderKey}');
    }
  }

  Widget _submitButton(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => Get.offAllNamed(Routes.home),
          child: TextButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              backgroundColor: MaterialStateProperty.all<Color>(LightColor.orange),
            ),
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 4),
              width: AppTheme.fullWidth(context) * .75,
              child: TitleText(
                text: 'Continue Shopping',
                color: LightColor.background,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        InkWell(
          onTap: () => Get.offAllNamed(Routes.orders),
          child: TextButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              backgroundColor: MaterialStateProperty.all<Color>(LightColor.orange),
            ),
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 4),
              width: AppTheme.fullWidth(context) * .75,
              child: TitleText(
                text: 'Track Order',
                color: LightColor.background,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Icon(Icons.check_circle_outline, color: LightColor.orange, size: 250),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(child: TitleText(text: "order_confirmed".tr)),
                    SizedBox(height: 20),
                    Center(child: Text("Order Key: ${orderResponse.orderKey}")),
                    SizedBox(height: 20),
                    Center(child: Text("Created at: ${orderResponse.dateCreated}")),
                    SizedBox(height: 20),
                    Center(child: Text("Shipping: ${orderResponse.billing.address1}")),
                    SizedBox(height: 50),
                    _submitButton(context)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
