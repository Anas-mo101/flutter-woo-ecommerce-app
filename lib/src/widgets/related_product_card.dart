import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/modules/product/model/product.dart';
import 'package:flutter_ecommerce_app/src/themes/light_color.dart';
import 'package:flutter_ecommerce_app/src/widgets/title_text.dart';
import 'package:flutter_ecommerce_app/src/widgets/extentions.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../config/woo_store/woo_store_service.dart';

class RelatedProductCard extends StatelessWidget {
  final Product product;
  final ValueChanged<Product> onSelected;
  RelatedProductCard({Key key, this.product, this.onSelected}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    final currencyCode = Get.find<WooStoreService>().storeCurrency.code ?? '\$';

    return Container(
      decoration: BoxDecoration(
        color: Color(0xffeeeeee),
        // borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: <BoxShadow>[
          BoxShadow(color: Color(0xfff8f8f8), blurRadius: 15, spreadRadius: 10),
        ],
      ),
      // margin: EdgeInsets.symmetric(vertical: !product.isSelected ? 20 : 0),
      child: Container(
        // padding: EdgeInsets.fromLTRB(0,25,0,10),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                product.image.isEmpty ?
                  Icon(Icons.image_not_supported) :
                    Center(child: Image.network(product.image[0])),
                SizedBox(height: 5),
                TitleText(
                  text: product.name.length > 20 ? product.name.substring(0,20) + '...' : product.name,
                  fontSize: product.isSelected ? 16 : 14,
                ),
                TitleText(
                  text: product.price.toString() + ' $currencyCode',
                  fontSize: product.isSelected ? 18 : 16,
                ),
              ],
            ),
          ],
        ),
      ).ripple(() {
        onSelected(product);
      }, borderRadius: BorderRadius.all(Radius.circular(20))),
    );
  }
}
