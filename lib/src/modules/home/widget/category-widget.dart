import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../themes/theme.dart';
import '../../../widgets/product_icon.dart';
import '../controller/home_controller.dart';

class CategoryWidget extends StatelessWidget {
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: AppTheme.fullWidth(context),
      height: 80,
      child: GetBuilder<HomeController>(
        init: HomeController(),
        builder: (_) {
          return ListView(
            scrollDirection: Axis.horizontal,
            children: controller.categoryList
                .map(
                  (category) => ProductIcon(model: category, onSelected: (model) => controller.toggleCategoryOptions(model)),
                )
                .toList(),
          );
        },
      ),
    );
  }
}
