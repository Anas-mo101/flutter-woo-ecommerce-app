import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/themes/light_color.dart';
import 'package:flutter_ecommerce_app/src/themes/theme.dart';
import 'package:flutter_ecommerce_app/src/widgets/extentions.dart';
import 'package:flutter_ecommerce_app/src/widgets/title_text.dart';
import 'package:get/get.dart';
import '../../../config/route.dart';
import '../controller/search_controller.dart';

class SearchFilter extends StatelessWidget {
  SearchFilter({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchController>(
        init: SearchController(),
        builder: (controller) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () => controller.setFilter(),
              backgroundColor: LightColor.orange,
              child: Icon(Icons.done,
                  color: Theme.of(context).floatingActionButtonTheme.backgroundColor),
            ),
            body: Stack(
              children: <Widget>[
                Positioned(
                  top: 55,
                  left: 10,
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: LightColor.iconColor, style: BorderStyle.solid),
                      borderRadius: BorderRadius.all(Radius.circular(13)),
                    ),
                    child: Center(child: Icon(Icons.close, color: LightColor.iconColor)),
                  ).ripple(() {
                      Get.offAndToNamed(Routes.search);
                  }, borderRadius: BorderRadius.all(Radius.circular(13))),
                ),
                Center(
                  heightFactor: 1.5,
                  child: TitleText(
                    text: "ECM",
                    fontSize: 160,
                    color: LightColor.lightGrey,
                  ),
                ),
                _filterWidget()
              ],
            ),
          );
        },
    );
  }

  Widget _filterWidget() {
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
              color: Colors.white
          ),
          child: GetBuilder<SearchController>(
            init: SearchController(),
            builder: (controller) {
               return SingleChildScrollView(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TitleText(text: 'filter'.tr, fontSize: 25),
                        InkWell(
                          onTap: (){
                            controller.searchFilterEnabled = false;
                            controller.searchFilter = null;
                            Get.offAndToNamed(Routes.search);
                          },
                          child: Container(
                            height: 40,
                            width: 80,
                            decoration: BoxDecoration(
                              border: Border.all(color: LightColor.iconColor, style: BorderStyle.solid),
                              borderRadius: BorderRadius.all(Radius.circular(13)),
                            ),
                            child: Center(child: Text('reset filter')),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 50),
                    Text('Filter by Price'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${controller.searchPriceRange.start}'),
                        Expanded(
                          child: RangeSlider(
                              min: 10.0,
                              max: 1000.0,
                              divisions: 50,
                              values: controller.searchPriceRange,
                              onChanged: (RangeValues newValues) => {
                                controller.searchPriceRange = newValues,
                                controller.update()
                              }
                          ),
                        ),
                        Text('${controller.searchPriceRange.end}'),
                      ],
                    ),
                    SizedBox( height: 20),
                    Text('Filter by Category'),
                    SizedBox( height: 10),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          )
                      ),
                      child: DropdownButton<String>(
                          hint: Text(
                              '${'Category'.tr} - ${controller.categoryList[controller.selectedCategoryFilter].name}',
                              style: TextStyle(fontSize: 14)
                          ),
                          isExpanded: true,
                          underline: Container(),
                          borderRadius: BorderRadius.circular(15.0),
                          items: [
                            ...controller.categoryList.map((e) =>
                              DropdownMenuItem(
                                child: Text(e.name),
                                value: e.id.toString(),
                              )
                            ),
                          ],
                          onChanged: (String newValue) => controller.toggleCategoryFilter(newValue)
                      ),
                    ),
                  ],
                ),
              );
            }
          ),
        );
      },
    );
  }
}
