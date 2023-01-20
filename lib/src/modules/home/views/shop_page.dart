import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/model/data.dart';
import 'package:flutter_ecommerce_app/src/themes/light_color.dart';
import 'package:flutter_ecommerce_app/src/themes/theme.dart';
import 'package:flutter_ecommerce_app/src/widgets/product_card.dart';
import 'package:flutter_ecommerce_app/src/widgets/extentions.dart';
import 'package:get/get.dart';
import '../../../config/route.dart';
import '../widget/category-widget.dart';


class ShopPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          dragStartBehavior: DragStartBehavior.down,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _search(context),
              CategoryWidget(),
              _productWidget(context),
              _productWidget(context),
              SizedBox(height: 40)
            ],
          ),
        )
    );
  }

  Widget _icon(BuildContext context, IconData icon, {Color color = LightColor.iconColor}) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(13)),
          color: Theme.of(context).backgroundColor,
          boxShadow: AppTheme.shadow
      ),
      child: Icon(icon, color: color),
    ).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(13)));
  }

  Widget _productWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: AppTheme.fullWidth(context),
      height: AppTheme.fullWidth(context) * .7,
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1, childAspectRatio: 4 / 3, mainAxisSpacing: 30, crossAxisSpacing: 20),
        padding: EdgeInsets.only(left: 20),
        scrollDirection: Axis.horizontal,
        children: AppData.productList
            .map(
              (product) => ProductCard(
                product: product,
                onSelected: (model) {
                  Get.toNamed(Routes.product, arguments: model.id);
                },
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _search(BuildContext context) {
    return Container(
      margin: AppTheme.padding,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: LightColor.lightGrey.withAlpha(100),
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search Products",
                    hintStyle: TextStyle(fontSize: 12),
                    contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 5),
                    prefixIcon: Icon(Icons.search, color: Colors.black54)
                ),
              ),
            ),
          ),
          SizedBox(width: 20),
          _icon(context,Icons.filter_list, color: Colors.black54)
        ],
      ),
    );
  }
}
