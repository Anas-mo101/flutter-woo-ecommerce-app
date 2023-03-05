import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/themes/light_color.dart';
import 'package:flutter_ecommerce_app/src/widgets/extentions.dart';
import 'package:get/get.dart';
import '../../../themes/theme.dart';
import '../../../widgets/title_text.dart';
import '../../../widgets/topbar.dart';
import '../controller/complain_controller.dart';
import '../model/user_complain.dart';

class ComplainPage extends StatelessWidget {

  final complainController = Get.put(ComplainController());

  Widget _icon(
      IconData icon, {
        Color color = LightColor.iconColor,
        double size = 20,
        double padding = 10,
        bool isOutLine = false,
        Function onPressed,
      }) {
    return Container(
      height: 40,
      width: 40,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        border: Border.all(color: LightColor.iconColor, style: isOutLine ? BorderStyle.solid : BorderStyle.none),
        borderRadius: BorderRadius.all(Radius.circular(13)),
      ),
      child: Center(child: Icon(icon, color: color, size: size)),
    ).ripple(() {
      if (onPressed != null) {
        onPressed();
      }
    }, borderRadius: BorderRadius.all(Radius.circular(13)));
  }

  Widget _appBar() {
    return Container(
      padding: AppTheme.padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
            size: 15,
            padding: 12,
            isOutLine: true,
            onPressed: () => Get.back(),
          ),
        ],
      ),
    );
  }

  Widget complainMessages(List<UserMessages> userMessages){
    List<Widget> messages = userMessages.map((e) => Column(
      children: [
        Row(
          mainAxisAlignment: e.sender == 'client' ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            SizedBox(width: 15),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
              ),
              width: AppTheme.fullWidth(Get.context) * .75,
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(e.message, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                  SizedBox(height: 15),
                  Text(e.sendingDatetime),
                ],
              ),
            ),
            SizedBox(width: 15)
          ],
        ),
        SizedBox(height: 15)
      ],
    )).toList();

    return Container(
      child: Column(
        children: [
          ...messages
        ],
      ),
    );
  }

  Widget sendMessage(bool loading){
    return Container(
      height: AppTheme.fullHeight(Get.context) * .10,
      color: Colors.white,
      padding: AppTheme.padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: AppTheme.fullWidth(Get.context) * .75,
            child: TextField(
              controller: complainController.messagingField,
              decoration: InputDecoration(
                // errorText: controller.cusShippingErr ? 'invalid_input'.tr : null,
                border:  OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
                hintText: 'Send Message',
                hintStyle: TextStyle(fontSize: 15),
                // contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 5),
              ),
            ),
          ),
          if(!loading)
          InkWell(
            onTap: () => complainController.sendMessage(),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(13)),
                color: Theme.of(Get.context).backgroundColor,
              ),
              child: Icon(Icons.send, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: GetBuilder<ComplainController>(
        init: ComplainController(),
        builder: (controller) {
          return Column(
            children: <Widget>[
              TopBar(
                  '${controller.complain.userTitle}',
                  Icons.arrow_back_ios_new_rounded,
                  () => Get.back(),
                  rightIcon: null
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: LightColor.orange,
                    // borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
                  ),
                  child: SingleChildScrollView(
                    controller: controller.scrollController,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 40),
                        controller.isLoading ?
                        Center(child: CircularProgressIndicator()) :
                        complainMessages(controller.complain.userMessages)
                      ],
                    ),
                  ),
                ),
              ),
              sendMessage(controller.isLoading)
            ],
          );
          }
        ),
      ),
    );
  }
}
