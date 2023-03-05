import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/themes/light_color.dart';
import 'package:flutter_ecommerce_app/src/themes/theme.dart';
import 'package:flutter_ecommerce_app/src/widgets/title_text.dart';
import 'package:get/get.dart';
import '../../../config/route.dart';
import '../../../widgets/topbar.dart';
import '../controller/complains_controller.dart';
import '../model/user_complain.dart';

class ComplainsPage extends StatelessWidget {
  ComplainsPage({Key key}) : super(key: key);

  final complainsController = Get.put(ComplainsController());

  List<Widget> _complainsItems(BuildContext context, List<UserComplain> items) {
    if (items.isEmpty) return [];
    return items.map((e) => _item(e)).toList();
  }

  List<Widget> _createReport(){

    return [
      SizedBox(height: 20),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(
              width: 1.0,
            )
        ),
        child: DropdownButton<String>(
          hint: Text('', style: TextStyle(fontSize: 14)),
          value: complainsController.statues[complainsController.selectedStatues],
          isExpanded: true,
          underline: Container(),
          borderRadius: BorderRadius.circular(15.0),
          items: [
            ...complainsController.statues.map((e) => DropdownMenuItem(
              child: Text(e),
              value: e,
            )),
          ],
          onChanged: (String newValue) => complainsController.toggleStatus(newValue),
        ),
      ),
      SizedBox(height: 30),
      TextField(
        controller: complainsController.complainTitle,
        decoration: InputDecoration(
          errorText: complainsController.titleError ? 'invalid_input'.tr : null,
          border:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Colors.blue, width: 2.0),
          ),
          hintText: 'Report Title',
          hintStyle: TextStyle(fontSize: 12),
          contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 5),
        ),
      ),
      SizedBox(height: 30),
      TextField(
        controller: complainsController.complainMessage,
        decoration: InputDecoration(
          errorText: complainsController.messageError ? 'invalid_input'.tr : null,
          border:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Colors.blue, width: 2.0),
          ),
          hintText: 'Message',
          hintStyle: TextStyle(fontSize: 12),
          contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 5),
        ),
      ),
      SizedBox(height: 30),
    ];
  }

  Widget _item(UserComplain complain) {

    if(complain.userTitle.length > 15){
      complain.userTitle = complain.userTitle.substring(0,15) + '...';
    }

    return ListTile(
      leading: Icon(Icons.shopping_basket_outlined , color: Colors.black, size: 35),
        title: TitleText(
          text: '${complain.userTitle} - #${complain.complainID}',
          fontSize: 17,
          fontWeight: FontWeight.w700,
        ),
        subtitle: Row(
          children: <Widget>[
            TitleText(
              text: '${complain.complainStatus}',
              color: LightColor.red,
              fontSize: 13,
            ),
          ],
        ),
        trailing: Container(
          width: 40,
          child: InkWell(
            onTap: () => Get.toNamed(Routes.complain, arguments: complain.toJson()),
            child: Container(
              width: 35,
              height: 35,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: LightColor.lightGrey.withAlpha(150), borderRadius: BorderRadius.circular(10)),
              child: Center(child: Icon(Icons.arrow_forward_ios, color: Colors.black, size: 20)),
            ),
          ),
        )
    );
  }

  void addNewAddress(BuildContext context){
    showModalBottomSheet(
      context: context,
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.only(
          topStart: Radius.circular(20),
          topEnd: Radius.circular(20),
        ),
      ),
      builder: (mcontext) => Container(
        height: 700,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TitleText(text: "Report"),
                if(complainsController.isLoading)
                  SizedBox(
                      height: 300,
                      child: Center(child: CircularProgressIndicator())
                  )
                else
                  ..._createReport(),
                TextButton(
                  onPressed: () => {
                    if(complainsController.validateInfo()){
                      complainsController.createComplain(),
                      Navigator.pop(mcontext)
                    }
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
                      text: 'Send Report',
                      color: LightColor.background,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: GetBuilder<ComplainsController>(
              init: ComplainsController(),
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
                                'Complains',
                                Icons.arrow_back_ios_new_rounded, () => Get.back(),
                                rightIcon: null
                            ),
                            Expanded(
                              child: controller.isLoading ?
                              Center(child: CircularProgressIndicator()) :
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: controller.complains.isEmpty ?
                                Center(child: Text('No Complains')) :
                                SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      ..._complainsItems(context, controller.complains),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              height: 70,
                              thickness: 1,
                            ),
                            TextButton(
                              onPressed: () => addNewAddress(context),
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
                                  text: 'New Complain',
                                  color: LightColor.background,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(height: 30)
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
