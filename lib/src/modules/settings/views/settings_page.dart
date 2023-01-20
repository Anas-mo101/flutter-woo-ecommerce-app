import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/themes/light_color.dart';
import 'package:flutter_ecommerce_app/src/themes/theme.dart';
import 'package:flutter_ecommerce_app/src/widgets/extentions.dart';
import 'package:flutter_ecommerce_app/src/widgets/title_text.dart';
import 'package:get/get.dart';
import '../../../config/route.dart';
import '../../cart/controller/cart_controller.dart';
import '../controllers/settings_controller.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key key}) : super(key: key);

  final settingsController = Get.put(SettingsController());


  Widget _icon(BuildContext context, IconData icon, {Color color = LightColor.iconColor}) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(13)), color: Theme
          .of(context)
          .backgroundColor, boxShadow: AppTheme.shadow),
      child: Icon(icon, color: color),
    ).ripple(() {
      Get.back();
    }, borderRadius: BorderRadius.all(Radius.circular(13)));
  }

  Widget _appBar(BuildContext context) {
    return Container(
      padding: AppTheme.padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
            child: RotatedBox(
              quarterTurns: 4,
              child: _icon(context, Icons.arrow_back_sharp, color: Colors.black54),
            ),
          ),
          TitleText(
            text: 'Settings',
            fontSize: 27,
            fontWeight: FontWeight.w400,
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(13)),
            child: Container(
              decoration: BoxDecoration(
                color: Theme
                    .of(context)
                    .backgroundColor,
                boxShadow: <BoxShadow>[
                  BoxShadow(color: Color(0xfff8f8f8), blurRadius: 10, spreadRadius: 10),
                ],
              ),
              child: Image.asset("assets/user.png"),
            ),
          )
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<CartController>(
            init: CartController(),
            builder: (controller) {
                return Stack(
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            _appBar(context),
                            Expanded(
                              child: Container(
                                padding: AppTheme.padding,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [

                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 30,horizontal: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[


                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
            }
        )

      ),
    );
  }
}
