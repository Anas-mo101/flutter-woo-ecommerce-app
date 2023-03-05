import 'package:get/get.dart';
import '../../product/model/product.dart';
import '../api/complain_api.dart';
import '../model/user_complain.dart';
import 'package:flutter/material.dart';

class ComplainController extends GetxController {

  bool isLoading = true;
  UserComplain complain;
  List<Product> orderProduct = [];

  ScrollController scrollController = new ScrollController(
    initialScrollOffset: 10.0,
    keepScrollOffset: true,
  );

  final messagingField = TextEditingController();

  @override
  void onInit() {
    var orderRes = Get.arguments;
    print('Order response:');
    print(orderRes);
    if(orderRes is Map<String, dynamic>){
      complain = UserComplain.fromJson(orderRes);
      init();
    }else{
      // Get.back();
    }
    super.onInit();
  }

  void init() async {
    await setComplain();

    isLoading = false;
    await update();
  }

  Future<void> setComplain() async {
    isLoading = true;
    update();

    try{
      complain = await UserComplainsApi().getComplain(complain.complainID);
      isLoading = false;
      update();
    }catch(e){
      print('setComplain failed :$e');
      // Get.back();
    }
  }

  Future<void> sendMessage() async {
    isLoading = true;
    update();

    try{
      String message = messagingField.value.text;
      complain = await UserComplainsApi().respondComplain(message, complain.complainID);
      messagingField.text = '';
    }catch(e){
      print('sendMessage failed :$e');
    }

    isLoading = false;
    update();
  }



}
