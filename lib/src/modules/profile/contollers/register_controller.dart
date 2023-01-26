import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/route.dart';
import '../api/auth_api.dart';

class RegisterController extends GetxController {

  final loginUsername = TextEditingController();
  final loginEmail = TextEditingController();
  final loginPassword = TextEditingController();
  final loginConfirmPassword = TextEditingController();

  bool loginEmailErr = false;
  bool loginPassErr = false;
  bool loginUserErr = false;
  bool loginConfirmPassErr = false;
  String loginStatus = '';

  Future<void> register() async {
    if(validateCreds()){
      if (await AuthApi().createUser(loginEmail.text, loginPassword.text, loginEmail.text)) {
        Get.offNamed(Routes.profile);
      } else {
        loginStatus = 'Can not create use with this credentials !';
        update();
      }
    }
  }

  bool validateCreds(){
    if(loginUsername.text.isEmpty){
      reset();
      loginUserErr = true;
      update();
      return false;
    }

    if(loginEmail.text.isEmpty && !isEmail(loginEmail.text)){
      reset();
      loginEmailErr = true;
      update();
      return false;
    }

    if(loginPassword.text.isEmpty && loginPassword.text.length > 8){
      reset();
      loginStatus = 'Passwords too short';
      loginPassErr = true;
      update();
      return false;
    }

    if(loginConfirmPassword.text.isEmpty){
      reset();
      loginConfirmPassErr = false;
      update();
      return false;
    }

    if(loginPassword.text.isEmpty != loginConfirmPassword.text.isEmpty){
      reset();
      loginStatus = 'Passwords not matching';
      update();
      return false;
    }

    update();
    return true;
  }

  void reset(){
    loginPassErr = false;
    loginUserErr = false;
    loginEmailErr = false;
    loginConfirmPassErr = false;
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