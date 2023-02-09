import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AdBillBoard extends StatelessWidget {
  const AdBillBoard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var followUp = Get.arguments;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            InkWell(
              onTap: (){
                Get.offAndToNamed(followUp);
              },
              child: Container(
                margin: EdgeInsets.all(20),
                  child: Icon(Icons.close)
              ),
            ),
            Align(
                child: Text('This is Ads !')
            )
          ],
        ),
      ),
    );
  }
}
