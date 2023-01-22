import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/themes/theme.dart';
import 'package:flutter_ecommerce_app/src/widgets/topbar.dart';
import 'package:get/get.dart';
import '../controllers/settings_controller.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key key}) : super(key: key);

  final settingsController = Get.put(SettingsController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<SettingsController>(
            init: SettingsController(),
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
                            TopBar('settings'.tr,Icons.arrow_back_sharp,() => Get.back() ),
                            Expanded(
                              child: Container(
                                padding: AppTheme.padding,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      SizedBox(height: 50),
                                      Text('general_settings'.tr),
                                      SizedBox(height: 20),
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15.0),
                                            border: Border.all(
                                              color: Colors.grey,
                                              width: 1.0,
                                            )
                                        ),
                                        child: DropdownButton<String>(
                                          hint: Text(
                                              '${'language'.tr} - ${controller.language[controller.selectedLanguage]}',
                                              style: TextStyle(fontSize: 14)
                                          ),
                                          isExpanded: true,
                                          underline: Container(),
                                          borderRadius: BorderRadius.circular(15.0),
                                          items: [
                                            ...controller.language.map((e) => DropdownMenuItem(
                                              child: Text(e),
                                              value: e,
                                            )),
                                          ],
                                          onChanged: (String newValue) => controller.toggleLanguage(newValue)
                                        ),
                                      ),
                                      Divider(
                                        thickness: 1,
                                        height: 70,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        width: AppTheme.fullWidth(context),
                                        padding: const EdgeInsets.symmetric(horizontal: 5),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15.0),
                                            border: Border.all(
                                              color: Colors.grey,
                                              width: 1.0,
                                            )
                                        ),
                                        child: ListTile(
                                          title: Text('More Settings'),
                                          leading: Icon(Icons.settings),
                                          trailing: Icon(Icons.arrow_forward_ios),
                                          onTap: (){

                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
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
