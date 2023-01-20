import 'package:get/get.dart';
import '../../../model/data.dart';

class HomeController extends GetxController {
  bool flag = false;

  // Category bar
  List categoryList = AppData.categoryList;

  void toggleCategoryOptions(dynamic model) {
    categoryList.forEach((element) {
      element.isSelected = false;
    });
    model.isSelected = true;
    update();
  }

  void onInit() {
    super.onInit();
  }

  void getHomeProducts() {}
}
