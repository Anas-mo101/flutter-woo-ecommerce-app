import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../themes/light_color.dart';
import '../../../themes/theme.dart';
import '../../../widgets/title_text.dart';
import '../../../widgets/topbar.dart';
import '../contollers/register_controller.dart';


class RegisterPage extends StatelessWidget {

  Widget _submitButton(BuildContext context, RegisterController controller) {
    return Column(
      children: [
        TextButton(
          onPressed: () {
            controller.register();
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
            width: AppTheme.fullWidth(context) * .75,
            child: TitleText(
              text: 'create_account'.tr,
              color: LightColor.background,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: 20),
        Text('or'.tr),
        SizedBox(height: 20),
        TextButton(
          onPressed: () {},
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(LightColor.orange),
          ),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 4),
            width: AppTheme.fullWidth(context) * .75,
            child: TitleText(
              text: 'register_with_google'.tr,
              color: LightColor.background,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: GetBuilder<RegisterController>(
              init: RegisterController(),
              builder: (controller) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TopBar(
                      'register'.tr,
                      Icons.arrow_back_rounded,
                          () => Get.back(),
                      rightIcon: null,
                    ),
                    SizedBox(height: 100),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextField(
                            controller: controller.loginUsername,
                            decoration: InputDecoration(
                              errorText: controller.loginUserErr ? 'invalid_input'.tr : null,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(color: Colors.blue, width: 2.0),
                              ),
                              hintText: "username".tr,
                              hintStyle: TextStyle(fontSize: 12),
                              contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 5),
                            ),
                          ),
                          SizedBox(height: 20),
                          TextField(
                            controller: controller.loginEmail,
                            decoration: InputDecoration(
                              errorText: controller.loginEmailErr ? 'invalid_input'.tr : null,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(color: Colors.blue, width: 2.0),
                              ),
                              hintText: "email".tr,
                              hintStyle: TextStyle(fontSize: 12),
                              contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 5),
                            ),
                          ),
                          SizedBox(height: 20),
                          TextField(
                            controller: controller.loginPassword,
                            decoration: InputDecoration(
                              errorText: controller.loginPassErr ? 'invalid_input'.tr : null,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(color: Colors.blue, width: 2.0),
                              ),
                              hintText: "password".tr,
                              hintStyle: TextStyle(fontSize: 12),
                              contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 5),
                            ),
                          ),
                          SizedBox(height: 20),
                          TextField(
                            controller: controller.loginConfirmPassword,
                            decoration: InputDecoration(
                              errorText: controller.loginConfirmPassErr ? 'invalid_input'.tr : null,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(color: Colors.blue, width: 2.0),
                              ),
                              hintText: "confirm_password".tr,
                              hintStyle: TextStyle(fontSize: 12),
                              contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 5),
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                    SizedBox(height: 100),
                    _submitButton(context, controller),
                  ],
                );
              }
            ),
          ),
        ),
      ),
    );
  }
}
