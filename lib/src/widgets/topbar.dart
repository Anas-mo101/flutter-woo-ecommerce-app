import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/widgets/extentions.dart';
import 'package:flutter_ecommerce_app/src/widgets/title_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../config/route.dart';
import '../themes/theme.dart';


class TopBar extends StatelessWidget {
  const TopBar(
      this.pageName,
      this.icon,
      this.goTo,
      {
        this.rightIcon = Icons.person,
        this.rightGoTo = Routes.login,
      }
  ) : super();

  final String pageName;
  final IconData icon;
  final Function goTo;
  final String rightGoTo;
  final IconData rightIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppTheme.padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
            child: RotatedBox(
              quarterTurns: 4,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(13)), color: Theme
                    .of(context)
                    .backgroundColor, boxShadow: AppTheme.shadow),
                child: Icon(icon, color: Colors.black54),
              ).ripple(() => goTo(), borderRadius: BorderRadius.all(Radius.circular(13))),
            ),
          ),
          TitleText(
            text: pageName,
            fontSize: 27,
            fontWeight: FontWeight.w400,
          ),
          rightIcon == null ? SizedBox(width: 25):
          InkWell(
            onTap: () => Get.toNamed(rightGoTo),
            child: ClipRRect(
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
                child: Icon(rightIcon, color: Colors.black54),
              ),
            ),
          )
        ],
      ),
    );
  }
}
