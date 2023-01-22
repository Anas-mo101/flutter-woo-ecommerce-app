import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/themes/light_color.dart';
import 'package:flutter_ecommerce_app/src/themes/theme.dart';
import 'package:flutter_ecommerce_app/src/widgets/title_text.dart';
import 'package:get/get.dart';
import '../../../config/route.dart';
import '../controller/search_controller.dart';

class SearchFilter extends StatelessWidget {
  SearchFilter({Key key}) : super(key: key);

  final searchController = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      floatingActionButton: _floatingButton(context),
      body: GetBuilder<SearchController>(
        init: SearchController(),
        builder: (controller) {
          return Stack(
            children: <Widget>[
              _productImage(context),
              _detailWidget()
            ],
          );
        },
      ),
    );
  }

  Widget _productImage(BuildContext context) {
    return Center(
      heightFactor: 1.5,
      child: TitleText(
        text: "ECM",
        fontSize: 160,
        color: LightColor.lightGrey,
      ),
    );
  }

  Widget _detailWidget() {
    return DraggableScrollableSheet(
      maxChildSize: .7,
      initialChildSize: .7,
      builder: (context, scrollController) {
        return Container(
          padding: AppTheme.padding.copyWith(bottom: 0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              color: Colors.white),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(height: 5),
                Container(
                  alignment: Alignment.center,
                  child: Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(color: LightColor.iconColor, borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TitleText(text: 'filter'.tr, fontSize: 25),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  FloatingActionButton _floatingButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Get.offAndToNamed(Routes.search),
      backgroundColor: LightColor.orange,
      child: Icon(Icons.done,
          color: Theme.of(context).floatingActionButtonTheme.backgroundColor),
    );
  }

}
