import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/themes/light_color.dart';
import 'package:flutter_ecommerce_app/src/themes/theme.dart';
import 'package:flutter_ecommerce_app/src/widgets/product_card.dart';
import 'package:flutter_ecommerce_app/src/widgets/title_text.dart';
import 'package:get/get.dart';
import '../../../config/route.dart';
import '../controller/home_controller.dart';

class ShopPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          dragStartBehavior: DragStartBehavior.down,
          child: GetBuilder<HomeController>(
            init: HomeController(),
            builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _search(context),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TitleText(text: 'Mens'),
                        InkWell(
                            onTap: (){

                            },
                            child: Text('view more')
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    width: AppTheme.fullWidth(context),
                    height: AppTheme.fullWidth(context),
                    child: controller.isLoading ? Center(child: CircularProgressIndicator()) :
                    GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 5 / 3,
                          mainAxisSpacing: 30.0,
                          crossAxisSpacing: 20.0
                      ),
                      padding: EdgeInsets.only(left: 20),
                      scrollDirection: Axis.horizontal,
                      children: controller.products.getRange((controller.products.length / 2).floor(), controller.products.length-1).map(
                          (product) => ProductCard( product: product, onSelected: (model) {
                            Get.toNamed(Routes.product, arguments: model.id);
                          },
                        ),
                      ).toList(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TitleText(text: 'Trending'),
                        InkWell(
                            onTap: (){

                            },
                            child: Text('view more')
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: controller.isLoading ? Center(child: CircularProgressIndicator()) :
                    Column(
                      children: [
                        ...controller.products.getRange(0, 3).map(
                              (product) => ProductCard(
                            product: product,
                            onSelected: (model) {
                              Get.toNamed(Routes.product, arguments: model.id);
                            },
                          ),
                        ).toList()
                      ],
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TitleText(text: 'Women'),
                        InkWell(
                          onTap: (){

                          },
                          child: Text('view more')
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    width: AppTheme.fullWidth(context),
                    height: AppTheme.fullWidth(context),
                    child: controller.isLoading ? Center(child: CircularProgressIndicator()) :
                    GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 5 / 3,
                          mainAxisSpacing: 30.0,
                          crossAxisSpacing: 20.0
                      ),
                      padding: EdgeInsets.only(left: 20),
                      scrollDirection: Axis.horizontal,
                      children: controller.products.getRange(0, (controller.products.length / 2).floor()).map(
                            (product) => ProductCard(
                          product: product,
                          onSelected: (model) {
                            Get.toNamed(Routes.product, arguments: model.id);
                          },
                        ),
                      ).toList(),
                    ),
                  ),
                  SizedBox(height: 50)
                ],
              );
            }
          )
        )
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
                onSubmitted: (String value) {
                  print('SEARCH: $value');
                  Get.toNamed(Routes.search, arguments: value);
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "search_products".tr,
                    hintStyle: TextStyle(fontSize: 12),
                    contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 5),
                    prefixIcon: Icon(Icons.search, color: Colors.black54)
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
