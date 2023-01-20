import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/modules/product/model/product.dart';
import 'package:flutter_ecommerce_app/src/themes/light_color.dart';
import 'package:flutter_ecommerce_app/src/themes/theme.dart';
import 'package:flutter_ecommerce_app/src/widgets/extentions.dart';
import 'package:flutter_ecommerce_app/src/widgets/title_text.dart';
import 'package:get/get.dart';
import '../../../config/route.dart';
import '../../../widgets/bottom_navigation_bar.dart';
import '../../home/widget/category-widget.dart';
import '../controller/search_controller.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key key}) : super(key: key);

  final searchController = Get.put(SearchController());

  Widget _search(BuildContext context) {
    return Container(
      margin: AppTheme.padding,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: LightColor.lightGrey.withAlpha(100), borderRadius: BorderRadius.all(Radius.circular(10))),
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
        ],
      ),
    );
  }

  Widget _item(Product model) {
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
                          onTap: () {},
                          child: Container(
                            width: 35,
                            height: 35,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(color: LightColor.lightGrey.withAlpha(150), borderRadius: BorderRadius.circular(10)),
                            child: TitleText(
                              text: 'add',
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
              )
          )
        ],
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
            text: 'Search',
            fontSize: 27,
            fontWeight: FontWeight.w400,
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(13)),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
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
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                height: AppTheme.fullHeight(context) - 50,
                child: Column(
                  children: <Widget>[
                    _appBar(context),
                    GetBuilder<SearchController>(
                        init: SearchController(),
                        builder: (controller) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _search(context),
                              SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Filter by Category'),
                                      InkWell(
                                        onTap: () => Get.toNamed(Routes.filter),
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(13)), color: Theme
                                              .of(context)
                                              .backgroundColor, boxShadow: AppTheme.shadow),
                                          child: Icon(Icons.filter_list, color: Colors.black54),
                                        ),
                                      )
                                    ]
                                ),
                              ),
                              CategoryWidget(),
                              Column(
                                children: [
                                  // search results
                                ],
                              )
                            ],
                          );
                        }
                     )
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
        ),
      ),
    );
  }
}
