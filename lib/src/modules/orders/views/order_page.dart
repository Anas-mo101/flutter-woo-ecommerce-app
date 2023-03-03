import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/themes/light_color.dart';
import 'package:flutter_ecommerce_app/src/widgets/extentions.dart';
import 'package:get/get.dart';
import '../../../config/route.dart';
import '../../../themes/theme.dart';
import '../../../widgets/related_product_card.dart';
import '../../../widgets/title_text.dart';
import '../../product/model/product.dart';
import '../controller/order_controller.dart';

class PreviewOrderPage extends StatelessWidget {

  Widget _relatedProducts(List<Product> products){
    if(products.isEmpty){
      return Container();
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          TitleText(
            text: "Order Items",
            fontSize: 14,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            width: AppTheme.fullWidth(Get.context),
            height: AppTheme.fullWidth(Get.context)/1.5,
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 3 / 3,
                  mainAxisSpacing: 30.0,
                  crossAxisSpacing: 20.0
              ),
              // padding: EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              children: products.map( (product) => RelatedProductCard( product: product, onSelected: (model) {
                Get.toNamed(Routes.product, arguments: model.id);
              }),
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }


  Widget _icon(
      IconData icon, {
        Color color = LightColor.iconColor,
        double size = 20,
        double padding = 10,
        bool isOutLine = false,
        Function onPressed,
      }) {
    return Container(
      height: 40,
      width: 40,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        border: Border.all(color: LightColor.iconColor, style: isOutLine ? BorderStyle.solid : BorderStyle.none),
        borderRadius: BorderRadius.all(Radius.circular(13)),
      ),
      child: Center(child: Icon(icon, color: color, size: size)),
    ).ripple(() {
      if (onPressed != null) {
        onPressed();
      }
    }, borderRadius: BorderRadius.all(Radius.circular(13)));
  }

  Widget _appBar() {
    return Container(
      padding: AppTheme.padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
            size: 15,
            padding: 12,
            isOutLine: true,
            onPressed: () => Get.back(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: GetBuilder<OrderController>(
        init: OrderController(),
        builder: (controller) {
          String date = DateTime.parse(controller.order.dateCreated).toString();

          return Column(
            children: <Widget>[
              _appBar(),
              Icon(Icons.check_circle_outline, color: LightColor.orange, size: 250),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 40),
                        Center(child: TitleText(text: "order_confirmed".tr)),
                        SizedBox(height: 20),
                        Center(child: Text("Order Key: ${controller.order.id}")),
                        SizedBox(height: 20),
                        Center(child: Text("Created at: $date")),
                        SizedBox(height: 20),
                        Center(child: Text("Status at: ${controller.order.status}")),
                        SizedBox(height: 20),
                        Center(child: Text("Shipping: ${controller.order.billing.address1}")),
                        SizedBox(height: 20),
                        controller.isLoading ?
                        Center(child: CircularProgressIndicator()) :
                        _relatedProducts(controller.orderProduct),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
          }
        ),
      ),
    );
  }
}
