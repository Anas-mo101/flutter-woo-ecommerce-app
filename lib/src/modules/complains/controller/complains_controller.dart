import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../api/complain_api.dart';
import '../model/user_complain.dart';
import '../model/user_complain_init.dart';


class ComplainsController extends GetxController {

  bool isLoading = true;
  List<UserComplain> complains = [];

  final complainTitle = TextEditingController();
  final complainMessage = TextEditingController();

  bool titleError = false;
  bool messageError = false;

  List<String> statues = ['Broken Order', 'App Crash', 'Missing Item'];
  int selectedStatues = 0;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  void init() async {
    await _setComplains();

    isLoading = false;
    await update();
  }

  toggleStatus(String option) async {

    final opt = statues.indexWhere((element) => element == option);
    selectedStatues = opt == -1 ? 0 : opt;
    update();
  }

  bool validateInfo(){

    /// Validate Email
    if(complainTitle.value.text.isEmpty){
      print(2);

      resetError();
      titleError = true;
      update();
      return false;
    }

    /// Validate Phone
    if(complainMessage.value.text.isEmpty){
      print(3);

      resetError();
      messageError = true;
      update();
      return false;
    }

    return true;
  }

  void resetError(){
    titleError = false;
    messageError = false;
  }

  Future<void> _setComplains() async {
    try{
      complains = await UserComplainsApi().getComplains();
    }catch(e){
      complains = [];
    }
  }


  Future<void> createComplain() async {
    isLoading = true;
    update();

    try{
      UserComplain userComplain = await UserComplainsApi().createComplains(UserComplainInit(
        title: complainTitle.value.text,
        reason: statues[selectedStatues],
        message: complainMessage.value.text
      ));
      complains.add(userComplain);
    }catch(e){
      print('createComplain $e');
    }

    isLoading = false;
    update();
  }

}
