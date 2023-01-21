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
import '../controller/orders_controller.dart';

class OrderPage extends StatelessWidget {
  OrderPage({Key key}) : super(key: key);

  final orderController = Get.put(OrderController());

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
            text: 'Orders',
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
                child: Icon(Icons.person, color: Colors.black54),
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
        child: Stack(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TopBar('Orders',Icons.sort,() => Get.toNamed(Routes.settings)),
                    Expanded(
                      child: Container(
                        padding: AppTheme.padding,

                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: CustomBottomNavigationBar(initPanel: 3),
            )
          ],
        ),
      ),
    );
  }
}
