import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/modules/product/model/product.dart';
import 'package:flutter_ecommerce_app/src/themes/light_color.dart';
import 'package:flutter_ecommerce_app/src/themes/theme.dart';
import 'package:flutter_ecommerce_app/src/widgets/title_text.dart';
import 'package:get/get.dart';
import '../../../config/route.dart';
import '../../../widgets/topbar.dart';
import '../../cart/controller/cart_controller.dart';
import '../controller/checkout_controller.dart';

class CheckoutPage extends StatelessWidget {
  CheckoutPage({Key key}) : super(key: key);

  final checkoutController = Get.put(CheckoutController());

  List<Widget> _cartItems(BuildContext context, CheckoutController controller) {
    List<Product> items = controller.ongoingOrder.uniqueList;
    if (items.isEmpty) return [];
    List<Widget> itemsWidget = items.map((e) => _item(e)).toList();
    return itemsWidget;
  }

  Widget _item(Product model) {
    return Container(
      height: 80,
      child: Row(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.2,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    height: 70,
                    width: 70,
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            decoration: BoxDecoration(color: LightColor.lightGrey, borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: -20,
                  bottom: -20,
                  child: Image.asset(model.image),
                )
              ],
            ),
          ),
          Expanded(
              child: ListTile(
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
                    ],
                  ),
                  trailing: Container(
                    width: 90,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 35,
                          height: 35,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(color: LightColor.lightGrey.withAlpha(150), borderRadius: BorderRadius.circular(10)),
                          child: TitleText(
                            text: 'x${checkoutController.getQty(model.id)}',
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  )))
        ],
      ),
    );
  }

  Widget _price(int itemsCount, double subtotal) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TitleText(
          text: '$itemsCount Items',
          color: LightColor.grey,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        TitleText(
          text: '\$$subtotal',
          fontSize: 18,
        ),
      ],
    );
  }

  Widget tax(double tax) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TitleText(
          text: 'tax 4%',
          color: LightColor.grey,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        TitleText(
          text: '\$$tax',
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
          text: 'delivery',
          color: LightColor.grey,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        TitleText(
          text: '\$$delv',
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
          text: 'total',
          color: LightColor.grey,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        TitleText(
          text: '\$$total',
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
          text: 'payment',
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
          text: 'Shipping to',
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
            text: 'Pay',
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
                var order = Get.arguments;
                if(order is List) {
                  controller.calcCartItems(order);
                }

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
                            TopBar('Checkout',Icons.arrow_back_sharp,() => Get.back(), rightIcon: null),
                            Expanded(
                              child: Container(
                                padding: AppTheme.padding,
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
                              padding: EdgeInsets.symmetric(vertical: 30,horizontal: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Divider(
                                    thickness: 1,
                                    height: 70,
                                  ),
                                  _price(controller.getOrderTotalQty(),controller.ongoingOrder.subtotal),
                                  SizedBox(height: 30),
                                  tax(controller.getTax()),
                                  SizedBox(height: 30),
                                  del(controller.getDelv()),
                                  SizedBox(height: 30),
                                  total(controller.getGrandTotal()),
                                  SizedBox(height: 30),
                                  shippingTo(controller.ongoingOrder.customerShippingAddress),
                                  SizedBox(height: 30),
                                  paymentMethod(controller.ongoingOrder.paymentOption),
                                  SizedBox(height: 30),
                                  _submitButton(context),
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
}
