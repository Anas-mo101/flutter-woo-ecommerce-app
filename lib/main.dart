import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/config/route.dart';
import 'package:flutter_ecommerce_app/src/widgets/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'src/themes/theme.dart';
import 'package:get/get.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Commerce App',
      theme: AppTheme.lightTheme.copyWith(
        textTheme: GoogleFonts.mulishTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      // home: SplashScreen(),
      initialRoute: Routes.splash,
      getPages: Routes.getRoute(),
    );
  }
}
