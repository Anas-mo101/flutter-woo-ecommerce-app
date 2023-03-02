import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/modules/product/model/product.dart';
import 'package:flutter_ecommerce_app/src/themes/light_color.dart';
import 'package:flutter_ecommerce_app/src/themes/theme.dart';
import 'package:flutter_ecommerce_app/src/widgets/extentions.dart';
import 'package:flutter_ecommerce_app/src/widgets/title_text.dart';
import 'package:get/get.dart';
import '../../../config/route.dart';
import '../../../config/woo_store/woo_store_service.dart';
import '../../../widgets/bottom_navigation_bar.dart';
import '../../../widgets/topbar.dart';
import '../controller/cart_controller.dart';
import '../model/cart_item_product.dart';

class ShoppingCartPage extends StatelessWidget {
  ShoppingCartPage({Key key}) : super(key: key);

  final cartController = Get.put(CartController());
  final currencyCode = Get.find<WooStoreService>().storeCurrency.code ?? '\$';

  List<Widget> _cartItems(BuildContext context, List<CartItemProduct> items) {
    if (items.isEmpty) return [];
    return items.map((e) => _item(e)).toList();
  }

  // Widget __item(CartItemProduct model) {
  //   return Container(
  //     width: MediaQuery.of(Get.context).size.width * 0.94,
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: <Widget>[
  //         Padding(
  //           padding: const EdgeInsets.all(2.0),
  //           child: ConstrainedBox(
  //             constraints: BoxConstraints(
  //               maxWidth: MediaQuery.of(Get.context).size.width * 0.25,
  //               maxHeight: MediaQuery.of(Get.context).size.width * 0.25,
  //             ),
  //             child: model.image[0] == null && model.image.isEmpty ?
  //             Center(child: Icon(Icons.image_not_supported)) :
  //             Center(child: Image.network(model.image[0], scale: 8)),
  //           ),
  //         ),
  //         Stack(
  //           children: <Widget>[
  //             Container(
  //               width: MediaQuery.of(Get.context).size.width * 0.5,
  //               child: Padding(
  //                 padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
  //                 child: Text(
  //                   model.name,
  //                   style: TextStyle(
  //                     fontWeight: FontWeight.bold,
  //                     fontSize: 15,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             Positioned(
  //               bottom: 50,
  //               child: Container(
  //                 width: MediaQuery.of(Get.context).size.width * 0.5,
  //                 child: Padding(
  //                   padding: const EdgeInsets.fromLTRB(5, 10, 0, 0),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: <Widget>[
  //                       Row(
  //                         children: [
  //                           TitleText(
  //                             text: '\$ ',
  //                             color: LightColor.red,
  //                             fontSize: 12,
  //                           ),
  //                           TitleText(
  //                             text: model.price.toString(),
  //                             fontSize: 12,
  //                           ),
  //                           TitleText(
  //                             text: ' - ${model.variationIdentifier}',
  //                             fontSize: 12,
  //                           ),
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             SizedBox(height: 10),
  //             cartItemQuantity(model),
  //             SizedBox(height: 10),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _item(CartItemProduct model) {
    int qty = cartController.getQty(model.id, model.variationId);

    return ListTile(
        title: TitleText(
          text: model.name,
          fontSize: 15,
          fontWeight: FontWeight.w700,
        ),
        subtitle: Row(
          children: <Widget>[
            TitleText(
              text: '$currencyCode ',
              color: LightColor.red,
              fontSize: 12,
            ),
            TitleText(
              text: model.price.toString(),
              fontSize: 12,
            ),
            TitleText(
              text: ' - ${model.variationIdentifier}',
              fontSize: 12,
            ),
          ],
        ),
        leading: Container(
          decoration: BoxDecoration(color: LightColor.lightGrey, borderRadius: BorderRadius.circular(10)),
          child: model.image[0] == null && model.image.isEmpty ?
          Icon(Icons.image_not_supported) : Image.network(model.image[0], scale: 6),
        ),
        trailing: Container(
          width: 120,
          child: Row(
            children: [
              InkWell(
                onTap: () => cartController.removeFromCart(model.id,model.variationId),
                child: Container(
                  width: 35,
                  height: 35,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: LightColor.lightGrey.withAlpha(150), borderRadius: BorderRadius.circular(10)),
                  child: Center(child: Icon(qty > 1 ? Icons.remove : Icons.delete, color: Colors.black)),
                ),
              ),
              SizedBox(width: 5),
              Container(
                width: 35,
                height: 35,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: LightColor.orange, borderRadius: BorderRadius.circular(10)),
                child: TitleText(
                  text: 'x${cartController.getQty(model.id, model.variationId)}',
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 5),
              InkWell(
                onTap: () => cartController.incrementCartItems(model.id, model.variationId),
                child: Container(
                  width: 35,
                  height: 35,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: LightColor.lightGrey.withAlpha(150), borderRadius: BorderRadius.circular(10)),
                  child: Center(child: Icon(Icons.add, color: Colors.black)),
                ),
              ),
            ],
          ),
        )
    );
  }

  Widget _price() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TitleText(
          text: '${cartController.getCartTotal()} ${'items'.tr}',
          color: LightColor.grey,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        TitleText(
          text: '$currencyCode ${cartController.getPrice()}',
          fontSize: 18,
        ),
      ],
    );
  }

  Widget _submitButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        if(cartController.wooCartItems.isNotEmpty){
          Get.toNamed(Routes.billing, arguments: cartController.wooCartItems);
        }
      },
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
          text: 'checkout'.tr,
          color: LightColor.background,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: GetBuilder<CartController>(
            init: CartController(),
            builder: (controller) {
              List<CartItemProduct> items = controller.getCart();
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
                            TopBar('cart'.tr,Icons.sort,() => Get.toNamed(Routes.settings)),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: items.isEmpty ?
                                Center(child: Text('Cart is Empty')) :
                                SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      ..._cartItems(context, items),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 50),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Divider(
                                    thickness: 1,
                                    height: 70,
                                  ),
                                  _price(),
                                  SizedBox(height: 30),
                                  _submitButton(context),
                                  SizedBox(height: 30),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CustomBottomNavigationBar(initPanel: 2),
                    )
                  ],
                );
            }
        )
      ),
    );
  }
}
