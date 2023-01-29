import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:flutter_ecommerce_app/src/themes/light_color.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../config/route.dart';

class NavController extends GetxController {

  int _selectedIndex = 0;

  void toggleNavBar(int index, {String argument}){
    print(index);
    print(_selectedIndex);
    if(_selectedIndex == index){
      return;
    }

    _selectedIndex = index;
    switch (index) {
      case 0:
        Get.offAndToNamed(Routes.home);
        break;
      case 1:
        Get.offAndToNamed(Routes.search, arguments: argument);
        break;
      case 2:
        Get.offAndToNamed(Routes.cart);
        break;
      case 3:
        Get.offAndToNamed(Routes.orders);
        break;
      default:
        Get.offAndToNamed(Routes.home);
        break;
    }

    update();
  }

}


class CustomBottomNavigationBar extends StatelessWidget {
  CustomBottomNavigationBar({Key key, this.initPanel}) : super(key: key);

  int initPanel = 0;

  final navController = Get.put(NavController());


  Widget _icon(IconData icon, bool isEnable, int index) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        onTap: () => navController.toggleNavBar(index),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          alignment: isEnable ? Alignment.topCenter : Alignment.center,
          child: AnimatedContainer(
              height: isEnable ? 40 : 20,
              duration: Duration(milliseconds: 300),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: isEnable ? LightColor.orange : Colors.white,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: isEnable ? Color(0xfffeece2) : Colors.white,
                      blurRadius: 10,
                      spreadRadius: 5,
                      offset: Offset(5, 5),
                    ),
                  ],
                  shape: BoxShape.circle),
              child: Icon(icon,
                color: isEnable
                    ? LightColor.background
                    : Colors.black,
              ),
        ),
      ),
    ));
  }

  double _getButtonContainerWidth(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width > 400.0) {
      width = 400.0;
    }
    return width;
  }

  @override
  Widget build(BuildContext context) {
    final appSize = MediaQuery.of(context).size;
    final height = 60.0;
    navController._selectedIndex = initPanel;
    return Container(
      width: appSize.width,
      height: 60,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            bottom: 0,
            width: appSize.width,
            height: height - 10,
            child: Container(
              color: Colors.white,
            ),
          ),
          Positioned(
            left: (appSize.width - _getButtonContainerWidth(context)) / 2,
            top: 0,
            width: _getButtonContainerWidth(context),
            height: height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _icon(Icons.home, navController._selectedIndex == 0, 0),
                _icon(Icons.search, navController._selectedIndex == 1, 1),
                _icon(Icons.shopping_cart, navController._selectedIndex == 2, 2),
                _icon(Icons.shopping_bag, navController._selectedIndex == 3, 3),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
