import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/route.dart';
import '../../../themes/light_color.dart';
import '../../../themes/theme.dart';
import '../../../widgets/title_text.dart';
import '../../../widgets/topbar.dart';

class LoginController extends GetxController {
  final email = ''.obs;
  final password = ''.obs;

  void login() {
    // Handle login logic here
    if (email.value == 'test@example.com' && password.value == 'password') {
      // Navigate to the next page
      Get.offNamed('/profile');
    } else {}
  }
}

class LoginPage extends StatelessWidget {
  Widget _submitButton(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () {},
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
              text: 'Login',
              color: LightColor.background,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: 20),
        TextButton(
          onPressed: () {},
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
              text: 'Google',
              color: LightColor.background,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: 20),
        Text('or'),
        SizedBox(height: 20),
        TextButton(
          onPressed: () {
            Get.offAndToNamed(Routes.register);
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
              text: 'Register',
              color: LightColor.background,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TopBar('Login', Icons.arrow_back_rounded,() => Get.back()),
                SizedBox(height: 150),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextField(
                        decoration: InputDecoration(
                            border:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(color: Colors.blue, width: 2.0),
                            ),
                            hintText: "Email",
                            hintStyle: TextStyle(fontSize: 12),
                            contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 5),
                         ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(color: Colors.blue, width: 2.0),
                            ),
                            hintText: "Password",
                            hintStyle: TextStyle(fontSize: 12),
                            contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 5),
                       ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 150),
                _submitButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
