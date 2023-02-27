import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/themes/light_color.dart';
import 'package:flutter_ecommerce_app/src/themes/theme.dart';
import 'package:flutter_ecommerce_app/src/widgets/title_text.dart';
import 'package:get/get.dart';
import '../../../config/route.dart';
import '../../../widgets/topbar.dart';
import '../../cart/controller/cart_controller.dart';
import '../../cart/model/cart_item_product.dart';
import '../controller/checkout_controller.dart';

class CheckoutPage extends StatelessWidget {
  CheckoutPage({Key key}) : super(key: key);

  final checkoutController = Get.put(CheckoutController());

  List<Widget> _cartItems(BuildContext context, CheckoutController controller) {
    List<CartItemProduct> items = controller.getCart();
    if (items.isEmpty) return [];
    List<Widget> itemsWidget = items.map((e) => _item(e)).toList();
    return itemsWidget;
  }

  Widget _item(CartItemProduct model) {
    return ListTile(
        leading: Container(
          decoration: BoxDecoration(color: LightColor.lightGrey, borderRadius: BorderRadius.circular(10)),
          child: model.image[0] == null && model.image.isEmpty ?
          Icon(Icons.image_not_supported) : Image.network(model.image[0], scale: 6),
        ),
        title: TitleText(
          text: model.name,
          fontSize: 15,
          fontWeight: FontWeight.w700,
        ),
        subtitle: Row(
          children: <Widget>[
            TitleText(
              text: '\$ ',
              color: LightColor.red,
              fontSize: 12,
            ),
            TitleText(
              text: model.price.toString(),
              fontSize: 14,
            ),
            TitleText(
              text: ' - ${model.variationIdentifier}',
              fontSize: 12,
            ),
          ],
        ),
        trailing: Container(
          width: 35,
          height: 35,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: LightColor.lightGrey.withAlpha(150), borderRadius: BorderRadius.circular(10)),
          child: TitleText(
            text: 'x${checkoutController.getQty(model.id, model.variationId)}',
            fontSize: 12,
          ),
        )
    );
  }

  Widget _price(int itemsCount, double subtotal) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TitleText(
          text: '$itemsCount ${'items'.tr}',
          color: LightColor.grey,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        TitleText(
          text: '\$${subtotal.toStringAsFixed(2)}',
          fontSize: 18,
        ),
      ],
    );
  }

  Widget tax(double tax, String rate) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TitleText(
          text: '${'tax'.tr} $rate%',
          color: LightColor.grey,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        TitleText(
          text: '\$${tax.toStringAsFixed(2)}',
          fontSize: 18,
        ),
      ],
    );
  }

  Widget del(double delv) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TitleText(
          text: 'delivery'.tr,
          color: LightColor.grey,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        TitleText(
          text: '\$${delv.toStringAsFixed(2)}',
          fontSize: 18,
        ),
      ],
    );
  }

  Widget total(double total) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TitleText(
          text: 'total'.tr,
          color: LightColor.grey,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        TitleText(
          text: '\$${total.toStringAsFixed(2)}',
          fontSize: 18,
        ),
      ],
    );
  }

  Widget paymentMethod(String mth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TitleText(
          text: 'payment'.tr,
          color: LightColor.grey,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        TitleText(
          text: '$mth',
          fontSize: 15,
        ),
      ],
    );
  }

  Widget shippingTo(String to) {
    String displayName = to.length <= 20 ? to : '${to.substring(0,20)}...' ;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TitleText(
          text: 'shipping_to'.tr,
          color: LightColor.grey,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        TitleText(
          text: displayName,
          fontSize: 15,
        ),
      ],
    );
  }

  Widget _submitButton(BuildContext context) {
    return InkWell(
      onTap: (){
        CartController.emptyCart();
        Get.offAndToNamed(Routes.confirmation);
      },
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
            text: 'pay'.tr,
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            TopBar('checkout'.tr,Icons.arrow_back_sharp,() => Get.back(), rightIcon: null),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      ..._cartItems(context, controller),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 50),
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Divider(
                                    thickness: 1,
                                    // height: 70,
                                  ),
                                  if(controller.isLoading)
                                    CircularProgressIndicator()
                                  else
                                  ...totals(controller),
                                ],
                              ),
                            ),
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

  List<Widget> totals(CheckoutController controller){
    return [
      _price(controller.getOrderTotalQty(),controller.ongoingOrder.subtotal),
      SizedBox(height: 30),
      tax(controller.getTax(), controller.taxRatePercentage),
      SizedBox(height: 30),
      del(controller.getDelv()),
      SizedBox(height: 30),
      total(controller.getGrandTotal()),
      SizedBox(height: 30),
      shippingTo(controller.ongoingOrder.customerShippingAddress),
      SizedBox(height: 30),
      paymentMethod(controller.ongoingOrder.paymentOption),
      SizedBox(height: 30),
      _submitButton(Get.context),
    ];
  }
}
