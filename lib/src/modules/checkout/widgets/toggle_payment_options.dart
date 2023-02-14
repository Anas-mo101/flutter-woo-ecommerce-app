import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../themes/light_color.dart';
import '../controller/billing_controller.dart';
import '../controller/checkout_controller.dart';


class TogglePaymentOptions extends StatelessWidget{
  TogglePaymentOptions({Key key}) : super(key: key);

  final billingController = Get.put(BillingController());

  Widget paymentOptions(String option){
    // bool selected = billingController.paymentOptions.indexOf(option) == billingController.selectedPaymentOptions;
    int indexWhere = billingController.paymentOptions.indexWhere((element) => element.title == option);
    bool selected = indexWhere == billingController.selectedPaymentOptions;

    return InkWell(
      onTap: () => billingController.togglePaymentOption(option),
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
            child: Column(
              children: [
                Center(child: Text(option)),
                if(selected)
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(billingController.paymentOptions[indexWhere].description, textAlign: TextAlign.center),
                  ),
              ],
            ),
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
          ...billingController.paymentOptions.map((e) => paymentOptions(e.title))
        ],
      ),
    );
  }
}
