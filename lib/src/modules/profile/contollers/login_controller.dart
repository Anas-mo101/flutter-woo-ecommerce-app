import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/route.dart';
import '../api/auth_api.dart';

class LoginController extends GetxController {

  final loginEmail = TextEditingController();
  final loginPassword = TextEditingController();

  bool loginEmailErr = false;
  bool loginPassErr = false;
  String loginStatus = '';

  Future<void> login() async {
    if(validateCreds()){
      if (await AuthApi().authUser(loginEmail.text, loginPassword.text)) {
        Get.offNamed(Routes.profile);
      } else {
        loginStatus = 'Incorrect Username/Password';
        update();
      }
    }
  }

  bool validateCreds(){
    if(loginEmail.text.isEmpty && !isEmail(loginEmail.text)){
      loginEmailErr = true;
      update();
      return false;
    }

    if(loginPassword.text.isEmpty){
      loginPassErr = true;
      update();
      return false;
    }

    loginPassErr = false;
    loginEmailErr = false;
    update();
    return true;
  }

  bool isEmail(String email) {
    String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";
    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(email);
  }
}