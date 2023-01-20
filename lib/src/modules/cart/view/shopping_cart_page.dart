import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/modules/product/model/product.dart';
import 'package:flutter_ecommerce_app/src/themes/light_color.dart';
import 'package:flutter_ecommerce_app/src/themes/theme.dart';
import 'package:flutter_ecommerce_app/src/widgets/extentions.dart';
import 'package:flutter_ecommerce_app/src/widgets/title_text.dart';
import 'package:get/get.dart';
import '../../../config/route.dart';
import '../../../widgets/bottom_navigation_bar.dart';
import '../controller/cart_controller.dart';

class ShoppingCartPage extends StatelessWidget {
  ShoppingCartPage({Key key}) : super(key: key);

  final cartController = Get.put(CartController());

  List<Widget> _cartItems(BuildContext context, CartController controller) {
    List<Product> items = controller.getCart();
    if (items.isEmpty) return [];
    List<Widget> itemsWidget = items.map((e) => _item(e, controller.removeFromCart)).toList();
    return itemsWidget;
  }

  Widget _item(Product model, Function remove) {
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
                        InkWell(
                          onTap: () {
                            cartController.removeFromCart(model);
                          },
                          child: Container(
                            width: 35,
                            height: 35,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(color: LightColor.lightGrey.withAlpha(150), borderRadius: BorderRadius.circular(10)),
                            child: Center(child: Icon(Icons.delete, color: Colors.black)),
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          width: 35,
                          height: 35,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(color: LightColor.lightGrey.withAlpha(150), borderRadius: BorderRadius.circular(10)),
                          child: TitleText(
                            text: 'x${cartController.getQty(model.id)}',
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

  Widget _price() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TitleText(
          text: '${cartController.getCartTotal()} Items',
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
        if(cartController.uniquelist.isNotEmpty){
          Get.toNamed(Routes.checkout);
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
          text: 'Checkout',
          color: LightColor.background,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _icon(BuildContext context, IconData icon, {Color color = LightColor.iconColor}) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(13)), color: Theme
          .of(context)
          .backgroundColor, boxShadow: AppTheme.shadow),
      child: Icon(icon, color: color),
    ).ripple(() {
      Get.toNamed(Routes.settings);
    }, borderRadius: BorderRadius.all(Radius.circular(13)));
  }

  Widget _appBar(BuildContext context) {
    return Container(
      padding: AppTheme.padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          RotatedBox(
            quarterTurns: 4,
            child: _icon(context, Icons.sort, color: Colors.black54),
          ),
          TitleText(
            text: 'Cart',
            fontSize: 27,
            fontWeight: FontWeight.w400,
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(13)),
            child: Container(
              decoration: BoxDecoration(
                color: Theme
                    .of(context)
                    .backgroundColor,
                boxShadow: <BoxShadow>[
                  BoxShadow(color: Color(0xfff8f8f8), blurRadius: 10, spreadRadius: 10),
                ],
              ),
              child: Image.asset("assets/user.png"),
            ),
          ).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(13)))
        ],
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
                            _appBar(context),
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
                              padding: EdgeInsets.symmetric(vertical: 70,horizontal: 20),
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
                      child: CustomBottomNavigationBar(),
                    )
                  ],
                );
            }
        )

      ),
    );
  }
}
