import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/config/internationalization.dart';
import 'package:flutter_ecommerce_app/src/config/route.dart';
import 'package:flutter_ecommerce_app/src/config/woo_store/woo_store_service.dart';
import 'package:flutter_ecommerce_app/src/modules/ads/middleware/ads_middleware.dart';
import 'package:flutter_ecommerce_app/src/modules/profile/middleware/auth_middleware.dart';
import 'package:google_fonts/google_fonts.dart';
import 'src/themes/theme.dart';
import 'package:get/get.dart';


main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Get.putAsync<AuthService>(() => AuthService().init());
  await Get.putAsync<AdsService>(() => AdsService().init());
  await Get.putAsync<WooStoreService>(() => WooStoreService().init());

  runApp(MyApp());
}

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
