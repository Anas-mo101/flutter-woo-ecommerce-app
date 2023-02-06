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
import '../controller/cart_controller.dart';
import '../model/cart_item_product.dart';

class ShoppingCartPage extends StatelessWidget {
  ShoppingCartPage({Key key}) : super(key: key);

  final cartController = Get.put(CartController());

  List<Widget> _cartItems(BuildContext context, CartController controller) {
    List<CartItemProduct> items = controller.getCart();
    if (items.isEmpty) return [];
    return items.map((e) => _item(e)).toList();
  }

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
              text: '\$ ',
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
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
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
          text: '\$${cartController.getPrice()}',
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
