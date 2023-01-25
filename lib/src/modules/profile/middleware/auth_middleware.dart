import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../config/route.dart';
import '../api/auth_api.dart';

class AuthProfile {
  String token;
  String name;
  String email;
  String displayName;

  AuthProfile(this.token, this.name, this.email, this.displayName);
}

class AuthService extends GetxService {
  final storage = FlutterSecureStorage();
  AuthProfile authedUser;
  bool authed = false;
  String token = '';

  bool isAuthed() => authed;

  void unAuth(){
    authed = false;
    token = '';
  }

  Future<AuthService> init() async {
    // fetch token if available
    checkAuth();
    return this;
  }

  Future<void> checkAuth() async {
    String unValidatedToken = await storage.read(key: 'token');
    print('Stored unvalidated token $unValidatedToken');
    if (unValidatedToken != null) AuthApi().validateAuth(unValidatedToken).then((value) => {
        if(value){
          authed = true,
          token = unValidatedToken
        }
    });
  }

  void authCurrentUser(AuthProfile profile) {
    authed = true;
    authedUser = profile;
    storage.write(key: 'token', value: authedUser.token);
  }

  void unAuthCurrentUser() {
    authed = false;
    authedUser = null;
    storage.write(key: 'token', value: '');
  }
}

class AuthMiddle extends GetMiddleware {
  // Our middleware content

  @override
  RouteSettings redirect(String route) {
    bool isAuthed = Get.find<AuthService>().isAuthed();
    print('isAuthed: $isAuthed');

    return isAuthed ? null : RouteSettings(name: Routes.login);
  }
}
