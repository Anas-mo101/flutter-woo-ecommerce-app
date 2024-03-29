import 'package:flutter_ecommerce_app/src/modules/home/views/main_page.dart';
import 'package:get/get.dart';
import '../modules/ads/middleware/ads_middleware.dart';
import '../modules/ads/views/ads_bill_board.dart';
import '../modules/checkout/views/billing_page.dart';
import '../modules/checkout/views/checkout_page.dart';
import '../modules/checkout/views/confirmation_page.dart';
import '../modules/complains/views/complain_page.dart';
import '../modules/complains/views/complains_page.dart';
import '../modules/orders/views/order_page.dart';
import '../modules/orders/views/orders_page.dart';
import '../modules/product/views/product_detail.dart';
import '../modules/cart/view/shopping_cart_page.dart';
import '../modules/profile/middleware/auth_middleware.dart';
import '../modules/profile/views/addresses.dart';
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
  static const order = '/order';
  static const billing = '/billing';
  static const login = '/login';
  static const profile = '/profile';
  static const settings = '/settings';
  static const register = '/register';
  static const confirmation = '/confirmation';
  static const product = '/product';
  static const billboard = '/billboard';
  static const addresses = '/addresses';
  static const complains = '/complains';
  static const complain = '/complain';


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
        // MidScreensAdv()
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
      GetPage( name: login,  page: () => LoginPage()),
      GetPage( name: register,  page: () => RegisterPage()),
      GetPage( name: billboard,  page: () => AdBillBoard()),
      GetPage( name: order,  page: () => PreviewOrderPage()),
      GetPage( name: addresses,  page: () => AddressPage()),
      GetPage( name: complains,  page: () => ComplainsPage()),
      GetPage( name: complain,  page: () => ComplainPage()),
    ];
  }
}
