import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/config/internationalization.dart';
import 'package:flutter_ecommerce_app/src/config/route.dart';
import 'package:flutter_ecommerce_app/src/modules/ads/ads_middleware.dart';
import 'package:google_fonts/google_fonts.dart';
import 'src/themes/theme.dart';
import 'package:get/get.dart';


main() async => {
  await Get.putAsync<AdsService>(() => AdsService().init()),
  runApp(MyApp())
};

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
      initialRoute: Routes.splash,
      getPages: Routes.getRoute(),
      translations: Internationalization(),
      locale: Locale('en', 'US'),
      fallbackLocale: Locale('en', 'US')
    );
  }
}
