import 'package:flutter_ecommerce_app/src/modules/home/views/main_page.dart';
import 'package:get/get.dart';
import '../modules/checkout/views/checkout_page.dart';
import '../modules/orders/views/orders_page.dart';
import '../modules/product/views/product_detail.dart';
import '../modules/cart/view/shopping_cart_page.dart';
import '../modules/profile/views/login.dart';
import '../modules/profile/views/register.dart';
import '../modules/search/views/filter.dart';
import '../modules/search/views/search_page.dart';
import '../modules/settings/views/settings_page.dart';

class Routes {
  static const home = '/';
  static const cart = '/cart';
  static const search = '/search';
  static const filter = '/filter';
  static const checkout = '/checkout';
  static const orders = '/orders';
  static const profile = '/profile';
  static const settings = '/settings';
  static const register = '/register';
  static const product = '/product/:';


  static getRoute() {
    return [
      GetPage(name: home, page: () => MainPage()),
      GetPage(name: cart, page: () => ShoppingCartPage()),
      GetPage( name: product,  page: () => ProductDetailPage()),
      GetPage( name: search,  page: () => SearchPage()),
      GetPage( name: orders,  page: () => OrderPage()),
      GetPage( name: filter,  page: () => SearchFilter()),
      GetPage( name: checkout,  page: () => CheckoutPage()),
      GetPage( name: settings,  page: () => SettingsPage()),
      GetPage( name: profile,  page: () => LoginPage()),
      GetPage( name: register,  page: () => RegisterPage()),
    ];
  }
}
