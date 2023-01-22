import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/themes/light_color.dart';
import 'package:get/get.dart';
import '../../../config/route.dart';
import '../../../widgets/title_text.dart';


class ConfirmationPage extends StatelessWidget {
  ConfirmationPage({Key key}) : super(key: key);

  FloatingActionButton _floatingButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Get.offAllNamed(Routes.home);
      },
      backgroundColor: LightColor.orange,
      child: Icon(Icons.done, color: Theme.of(context).floatingActionButtonTheme.backgroundColor),
    );
  }

  Widget _productImage(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        TitleText(
          text: "AIP",
          fontSize: 160,
          color: LightColor.lightGrey,
        ),
        Image.asset('assets/show_1.png')
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _floatingButton(context),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xfffbfbfb),
                  Color(0xfff7f7f7),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),
          child: Column(
            children: <Widget>[
              _productImage(context),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(child: Text("order_confirmed".tr))
                  ],
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}
