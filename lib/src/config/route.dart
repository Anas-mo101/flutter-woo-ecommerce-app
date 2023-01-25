import 'package:flutter_ecommerce_app/src/modules/home/views/main_page.dart';
import 'package:get/get.dart';
import '../modules/ads/ads_middleware.dart';
import '../modules/ads/views/ads_bill_board.dart';
import '../modules/checkout/views/billing_page.dart';
import '../modules/checkout/views/checkout_page.dart';
import '../modules/checkout/views/confirmation_page.dart';
import '../modules/orders/views/orders_page.dart';
import '../modules/product/views/product_detail.dart';
import '../modules/cart/view/shopping_cart_page.dart';
import '../modules/profile/middleware/auth_middleware.dart';
import '../modules/profile/views/login.dart';
import '../modules/profile/views/profile.dart';
import '../modules/profile/views/register.dart';
import '../modules/search/views/filter.dart';
import '../modules/search/views/search_page.dart';
import '../modules/settings/views/settings_page.dart';
import '../widgets/splash_screen.dart';

class Routes {
  static const splash = '/';
  static const home = '/home';
  static const cart = '/cart';
  static const search = '/search';
  static const filter = '/filter';
  static const checkout = '/checkout';
  static const orders = '/orders';
  static const billing = '/billing';
  static const login = '/login';
  static const profile = '/profile';
  static const settings = '/settings';
  static const register = '/register';
  static const confirmation = '/confirmation';
  static const product = '/product';
  static const billboard = '/billboard';


  static getRoute() {
    return [
      GetPage(name: home, page: () => MainPage(), middlewares: [
        MidScreensAdv()
      ]),
      GetPage(name: splash, page: () => SplashScreen()),
      GetPage(name: cart, page: () => ShoppingCartPage(), middlewares: [
        MidScreensAdv()
      ]),
      GetPage( name: product,  page: () => ProductDetailPage(), middlewares: [
        MidScreensAdv()
      ]),
      GetPage( name: confirmation,  page: () => ConfirmationPage()),
      GetPage( name: search,  page: () => SearchPage(), middlewares: [
        MidScreensAdv()
      ]),
      GetPage( name: orders,  page: () => OrderPage(), middlewares: [
        MidScreensAdv()
      ]),
      GetPage( name: filter,  page: () => SearchFilter()),
      GetPage( name: billing,  page: () => BillingPage(), middlewares: [
        AuthMiddle()
      ]),
      GetPage( name: checkout,  page: () => CheckoutPage(), middlewares: [
        AuthMiddle()
      ]),
      GetPage( name: settings,  page: () => SettingsPage()),
      GetPage( name: profile,  page: () => ProfilePage(), middlewares: [
        AuthMiddle()
      ]),
      GetPage( name: login,  page: () => LoginPage(), middlewares: [
        // AuthMiddle()
      ]),
      GetPage( name: register,  page: () => RegisterPage()),
      GetPage( name: billboard,  page: () => AdBillBoard()),
    ];
  }
}
