import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/themes/theme.dart';
import 'package:flutter_ecommerce_app/src/widgets/topbar.dart';
import 'package:get/get.dart';
import '../../../config/route.dart';
import '../../../widgets/title_text.dart';
import '../../cart/controller/cart_controller.dart';
import '../middleware/auth_middleware.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key key}) : super(key: key);

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
                            TopBar(
                                'profile'.tr,
                                Icons.close,
                                () => Get.offAllNamed(Routes.home),
                                rightIcon: Icons.settings,
                                rightGoTo: Routes.settings,
                            ),
                            Expanded(
                              child: Container(
                                padding: AppTheme.padding,
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.person, size: 200),
                                      TitleText(text: Get.find<AuthService>().authedUser.displayName ?? 'Username'),
                                      SizedBox(height: 50),
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
                                          title: Text('Addresses'),
                                          leading: Icon(Icons.local_shipping),
                                          onTap: () => Get.toNamed(Routes.addresses),
                                        ),
                                      ),
                                      SizedBox(height: 20),
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
                                          title: Text('Complains'),
                                          leading: Icon(Icons.settings),
                                          onTap: (){

                                          },
                                        ),
                                      ),
                                      SizedBox(height: 20),
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
                                          title: Text('Logout'),
                                          leading: Icon(Icons.logout_outlined),
                                          onTap: (){
                                            Get.find<AuthService>().unAuth();
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
