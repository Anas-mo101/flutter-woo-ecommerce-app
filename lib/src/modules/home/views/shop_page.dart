import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/themes/light_color.dart';
import 'package:flutter_ecommerce_app/src/themes/theme.dart';
import 'package:flutter_ecommerce_app/src/widgets/product_card.dart';
import 'package:get/get.dart';
import '../../../config/route.dart';
import '../../../widgets/bottom_navigation_bar.dart';
import '../controller/home_controller.dart';
import '../widget/category-widget.dart';


class ShopPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          dragStartBehavior: DragStartBehavior.down,
          child: GetBuilder<HomeController>(
            init: HomeController(),
            builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _search(context),
                  CategoryWidget(),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    width: AppTheme.fullWidth(context),
                    height: AppTheme.fullWidth(context) * .7,
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
                      children: controller.products.map(
                            (product) => ProductCard(
                          product: product,
                          onSelected: (model) {
                            Get.toNamed(Routes.product, arguments: model.id);
                          },
                        ),
                      ).toList(),
                    ),
                  ),
                  SizedBox(height: 40)
                ],
              );
            }
          )
        )
    );
  }



  Widget _productWidget(BuildContext context, HomeController controller) {
    print(controller.products.length);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: AppTheme.fullWidth(context),
      height: AppTheme.fullWidth(context) * .7,
      child: controller.isLoading ? Center(child: CircularProgressIndicator()) :
      GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 4 / 3,
            crossAxisSpacing: 20.0
        ),
        padding: EdgeInsets.only(left: 20),
        scrollDirection: Axis.horizontal,
        children: controller.products.map(
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
                onSubmitted: (String value) {
                  final navController = Get.put(NavController());
                  navController.toggleNavBar(1, argument: value);
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
