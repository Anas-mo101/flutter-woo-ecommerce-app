import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/route.dart';

class SplashScreenController extends GetxController with GetSingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;

  @override
  void onInit() {
    animationInit();
    super.onInit();
  }

  animationInit() {
    animationController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation = CurvedAnimation(parent: animationController, curve: Curves.easeOut).obs.value;
    animation.addListener(() => update());
    animationController.forward();
    animationController.addStatusListener((status) {
      print(status.name);
      if(status.name == 'completed'){
        Get.offAndToNamed(Routes.home);
      }
    });
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SplashScreenController>(
        init: SplashScreenController(),
        builder: (controller) {
          return Stack(
            fit: StackFit.expand,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/shooe_tilt_1.png',
                    width: controller.animation.value * 200,
                    height: controller.animation.value * 200,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}