import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/themes/light_color.dart';

class LoadingProductCard extends StatelessWidget {
  LoadingProductCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        decoration: BoxDecoration(
          // color: LightColor.lightGrey,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(color: Color(0xfff8f8f8), blurRadius: 15, spreadRadius: 10),
          ],
        ),
        padding: EdgeInsets.fromLTRB(0,25,0,10),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  color: LightColor.lightGrey,
                  height: 200,
                ),
                SizedBox(height: 30),
                Container(
                  width: 200,
                  height: 10,
                  decoration: BoxDecoration(
                      color: LightColor.lightGrey,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: 100,
                  height: 10,
                  decoration: BoxDecoration(
                      color: LightColor.lightGrey,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: 50,
                  height: 10,
                  decoration: BoxDecoration(
                      color: LightColor.lightGrey,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
