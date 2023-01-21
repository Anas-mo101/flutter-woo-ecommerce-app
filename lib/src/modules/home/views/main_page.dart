import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/modules/home/views/shop_page.dart';
import 'package:flutter_ecommerce_app/src/themes/light_color.dart';
import 'package:flutter_ecommerce_app/src/themes/theme.dart';
import 'package:flutter_ecommerce_app/src/widgets/bottom_navigation_bar.dart';
import 'package:flutter_ecommerce_app/src/widgets/extentions.dart';
import 'package:get/get.dart';
import '../../../config/route.dart';
import '../../../widgets/topbar.dart';

class MainPage extends StatelessWidget {


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
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xfffbfbfb),
                      Color(0xfff7f7f7),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TopBar('Main',Icons.sort,() => Get.toNamed(Routes.settings)),
                    Expanded(
                      child: ShopPage(),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: CustomBottomNavigationBar(initPanel: 0),
            )
          ],
        ),
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

}
