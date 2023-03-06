import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../themes/light_color.dart';
import '../../../themes/theme.dart';
import '../../../widgets/title_text.dart';
import '../controllers/ads_controller.dart';
import 'package:url_launcher/url_launcher.dart';


class AdBillBoard extends StatelessWidget {
  const AdBillBoard({Key key}) : super(key: key);


  Widget _submitButton(String visitUrl) {
    return TextButton(
      onPressed: () {
        launchUrl(Uri.parse(visitUrl));
      },
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(LightColor.orange),
      ),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 4),
        width: AppTheme.fullWidth(Get.context) * .75,
        child: TitleText(
          text: 'Learn More',
          color: LightColor.background,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: GetBuilder<AdsController>(
        init: AdsController(),
        builder: (controller) {
          return SafeArea(
            child: Stack(
              children: [

                Align(
                    child: controller.isLoading ?
                    Center(child: CircularProgressIndicator()) :
                    Image.network(controller.ads.image, fit: BoxFit.fill)
                ),
                InkWell(
                  onTap: () => Get.offAndToNamed(controller.nextRoute),
                  child: Container(
                      margin: EdgeInsets.all(20),
                      child: Icon(Icons.close, color: Colors.grey)
                  ),
                ),
                if(!controller.isLoading && controller.ads.link != '' && controller.ads?.link != null )
                Positioned(
                    bottom: 10,
                    left: 10,
                    right: 10,
                    child: _submitButton(controller.ads.link)
                )
              ],
            ),
          );
        }
      )
    );
  }
}
