import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/modules/product/model/product.dart';
import 'package:flutter_ecommerce_app/src/themes/light_color.dart';
import 'package:flutter_ecommerce_app/src/themes/theme.dart';
import 'package:flutter_ecommerce_app/src/widgets/extentions.dart';
import 'package:flutter_ecommerce_app/src/widgets/title_text.dart';
import 'package:get/get.dart';
import '../../../config/route.dart';
import '../../../widgets/bottom_navigation_bar.dart';
import '../../../widgets/related_product_card.dart';
import '../../../widgets/topbar.dart';
import '../../product/api/woo_product_api.dart';
import '../../product/model/woocommerce_product.dart';
import '../controller/orders_controller.dart';
import '../model/woo_user_orders.dart';

class OrderPage extends StatelessWidget {
  OrderPage({Key key}) : super(key: key);

  List<Widget> _orderItems(BuildContext context, List<WooUserOrder> items) {
    if (items.isEmpty) return [];
    return items.map((e) => _item(e)).toList();
  }

  Widget _item(WooUserOrder order) {
    return ListTile(
      leading: Icon(Icons.shopping_basket_outlined , color: Colors.black, size: 35),
        title: TitleText(
          text: 'Order ID: ${order.id}',
          fontSize: 17,
          fontWeight: FontWeight.w700,
        ),
        subtitle: Row(
          children: <Widget>[
            TitleText(
              text: 'Order Status: ${order.status}',
              color: LightColor.red,
              fontSize: 13,
            ),
          ],
        ),
        trailing: Container(
          width: 40,
          child: InkWell(
            onTap: () => Get.toNamed(Routes.order, arguments: order.toJson()),
            child: Container(
              width: 35,
              height: 35,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: LightColor.lightGrey.withAlpha(150), borderRadius: BorderRadius.circular(10)),
              child: Center(child: Icon(Icons.arrow_forward_ios, color: Colors.black, size: 20)),
            ),
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: GetBuilder<OrdersController>(
              init: OrdersController(),
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
                            TopBar('orders'.tr,Icons.sort,() => Get.toNamed(Routes.settings)),
                            Expanded(
                              child: controller.isLoading ?
                              Center(child: CircularProgressIndicator()) :
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: controller.orders.isEmpty ?
                                Center(child: Text('No Orders')) :
                                SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      ..._orderItems(context, controller.orders),
                                    ],
                                  ),
                                ),
                              ),
                            ),
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
                );
              }
          )
      ),
    );
  }




}
