import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/themes/theme.dart';
import 'package:flutter_ecommerce_app/src/widgets/topbar.dart';
import 'package:get/get.dart';
import '../../../themes/light_color.dart';
import '../../../widgets/title_text.dart';
import '../contollers/addresses_controller.dart';
import '../models/address.dart';

class AddressPage extends StatelessWidget {
  AddressPage({Key key}) : super(key: key);

  final addressController = Get.put(AddressesController());

  List<Widget> _shippingInfo(AddressesController controller, {Address address}){

    if(address != null){
      controller.cusAddressOne.text = address.address1;
      controller.cusAddressTwo.text = address.address2;
      controller.cusCity.text = address.city;
      controller.cusZip.text = address.postcode;

      controller.selectedShippingOptions = controller.shippingOptions.indexWhere((element) => element.name == address.country);
      controller.selectedCountryState = controller.countryState.indexWhere((element) => element.name == address.state);
    }else{
      controller.cusAddressOne.text = '';
      controller.cusAddressTwo.text = '';
      controller.cusCity.text = '';
      controller.cusZip.text = '';
    }

    return [
      SizedBox(height: 20),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(
              // color: controller.cusCountryErr ? Colors.red : Colors.grey,
              width: 1.0,
            )
        ),
        child: DropdownButton<String>(
          hint: Text('country'.tr, style: TextStyle(fontSize: 14)),
          value: controller.shippingOptions[controller.selectedShippingOptions].name,
          isExpanded: true,
          underline: Container(),
          borderRadius: BorderRadius.circular(15.0),
          items: [
            ...controller.shippingOptions.map((e) => DropdownMenuItem(
              child: Text(e.name),
              value: e.name,
            )),
          ],
          onChanged: (String newValue) => controller.toggleShippingOption(newValue),
        ),
      ),
      SizedBox(height: 20),
      TextField(
        controller: controller.cusAddressOne,
        decoration: InputDecoration(
          errorText: controller.cusAddressOneErr ? 'invalid_input'.tr : null,
          border:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Colors.blue, width: 2.0),
          ),
          hintText: 'Street Address 1',
          hintStyle: TextStyle(fontSize: 12),
          contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 5),
        ),
      ),
      SizedBox(height: 20),
      TextField(
        controller: controller.cusAddressTwo,
        decoration: InputDecoration(
          errorText: controller.cusAddressTwoErr ? 'invalid_input'.tr : null,
          border:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          hintText: 'Street Address 2 (Optional)',
          hintStyle: TextStyle(fontSize: 12),
          contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 5),
        ),
      ),
      SizedBox(height: 20),
      TextField(
        controller: controller.cusCity,
        decoration: InputDecoration(
          errorText: controller.cusCityErr ? 'invalid_input'.tr : null,
          border:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          hintText: 'Town / City',
          hintStyle: TextStyle(fontSize: 12),
          contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 5),
        ),
      ),
      SizedBox(height: 20),
      if(controller.countryState.isNotEmpty)
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                color: controller.cusStateErr ? Colors.red : Colors.grey,
                width: 1.0,
              )
          ),
          child: DropdownButton<String>(
            hint: Text('country'.tr, style: TextStyle(fontSize: 14)),
            value: controller.countryState[controller.selectedCountryState].name,
            isExpanded: true,
            underline: Container(),
            borderRadius: BorderRadius.circular(15.0),
            items: [
              ...controller.countryState.map((e) => DropdownMenuItem(
                child: Text(e.name),
                value: e.name,
              )),
            ],
            onChanged: (String newValue) => controller.toggleCountryStates(newValue),
          ),
        ),
      SizedBox(height: 20),
      TextField(
        controller: controller.cusZip,
        decoration: InputDecoration(
          errorText: controller.cusZipErr ? 'invalid_input'.tr : null,
          border:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Colors.blue, width: 2.0),
          ),
          hintText: "zip_code".tr,
          hintStyle: TextStyle(fontSize: 12),
          contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 5),
        ),
      ),
      SizedBox(height: 30),
    ];
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
                TitleText(text: "Add New Address"),
                if(addressController.isCreateLoading)
                  SizedBox(
                    height: 300,
                    child: Center(child: CircularProgressIndicator())
                  )
                else
                  ..._shippingInfo(addressController),
                TextButton(
                  onPressed: () => {
                    if(addressController.validateAddressInfo()){
                      addressController.createUserAddress(addressController.getNewAddressInfo()),
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
                      text: 'Add Address',
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

  void editAddress(Address address){

    showModalBottomSheet(
      context: Get.context,
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
                TitleText(text: "Edit Address"),
                if(addressController.isCreateLoading)
                  SizedBox(
                      height: 300,
                      child: Center(child: CircularProgressIndicator())
                  )
                else
                  ..._shippingInfo(addressController, address: address),
                TextButton(
                  onPressed: () => {

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
                    width: AppTheme.fullWidth(mcontext) * .75,
                    child: TitleText(
                      text: 'Update Address',
                      color: LightColor.background,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () => {
                    print(address.key),
                    addressController.setDefault(address.key)
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
                    width: AppTheme.fullWidth(mcontext) * .75,
                    child: TitleText(
                      text: 'Set as default',
                      color: LightColor.background,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () => {
                    addressController.delete(address.key),
                    Navigator.pop(mcontext)
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(LightColor.red),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 4),
                    width: AppTheme.fullWidth(mcontext) * .75,
                    child: TitleText(
                      text: 'Delete',
                      color: Colors.white,
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

  Widget _submitButton(BuildContext context) {
    return TextButton(
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
          text: 'Add New Address',
          color: LightColor.background,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  List<Widget> _cartItems(List<Address> items) {
    if (items.isEmpty) return [];
    return items.map((e) => _item(e)).toList();
  }

  Widget _item(Address address) {
    bool def = addressController.defaultAddresses == address.key;

    return ListTile(
        title: TitleText(
          text: "Address: ${address.address1}",
          fontSize: 15,
          fontWeight: FontWeight.w700,
        ),
        subtitle: Row(
          children: <Widget>[
            TitleText(
              text: "country: ${address.country}",
              color: LightColor.red,
              fontSize: 12,
            ),
          ],
        ),
        leading: Icon(Icons.home, size: 30, color: def ? LightColor.orange : LightColor.lightGrey),
        trailing: Container(
          width: 40,
          child: InkWell(
            onTap: () {
              editAddress(address);
            },
            child: Container(
              width: 35,
              height: 35,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: LightColor.lightGrey.withAlpha(150), borderRadius: BorderRadius.circular(10)),
              child: Center(child: Icon(Icons.edit, color: Colors.black)),
            ),
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: GetBuilder<AddressesController>(
              init: AddressesController(),
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
                              'Addresses',
                              Icons.arrow_back_ios_new_rounded,
                              () => Get.back(),
                              rightIcon: null
                            ),
                            Expanded(
                              child: Container(
                                padding: AppTheme.padding,
                                child: SingleChildScrollView(
                                  child: controller.isLoading ?
                                  Center(child: CircularProgressIndicator()) :
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ..._cartItems(controller.addresses)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              child: Divider(
                                thickness: 1,
                                height: 70,
                              ),
                            ),
                            _submitButton(context),
                            SizedBox(height: 20)
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
