import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../config/route.dart';
import '../api/auth_api.dart';

class AuthProfile {
  String token;
  int id;
  String email;
  String name;
  String displayName;

  AuthProfile(
      {this.token,
        this.id,
        this.email,
        this.name,
        this.displayName});

  AuthProfile.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    id = checkInt(json['uesr_id']);
    email = json['user_email'];
    name = json['user_nicename'];
    displayName = json['user_display_name'];
  }

  static int checkInt(dynamic value) {
    if (value is String) {
      return int.parse(value);
    } else {
      return value.toInt();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['uesr_id'] = this.id;
    data['user_email'] = this.email;
    data['user_nicename'] = this.name;
    data['user_display_name'] = this.displayName;
    return data;
  }
}

class AuthService extends GetxService {
  final storage = FlutterSecureStorage();
  AuthProfile authedUser;
  bool authed = false;
  String token = '';

  bool isAuthed() => authed;

  Future<AuthService> init() async {
    // fetch token if available
    checkAuth();
    return this;
  }

  Future<void> checkAuth() async {
    String unValidatedToken = await storage.read(key: 'token');
    print('Stored unvalidated token $unValidatedToken');
    if (unValidatedToken != null) AuthApi().validateAuth(unValidatedToken).then((v) async {
      if(v){
        authed = true;
        token = unValidatedToken;
        String user = await storage.read(key: 'user');
        authedUser = AuthProfile.fromJson(jsonDecode(user));
      }
    }).catchError((e){
      print('AuthService checkAuth() failed : $e');
      unAuth();
    });
  }

  void authCurrentUser(AuthProfile profile) {
    authed = true;
    authedUser = profile;
    token = profile.token;
    storage.write(key: 'token', value: profile.token);
    storage.write(key: 'user', value: jsonEncode(profile.toJson()));
  }

  void unAuth() {
    authed = false;
    authedUser = null;
    storage.write(key: 'token', value: '');
    storage.write(key: 'user', value: '');
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
