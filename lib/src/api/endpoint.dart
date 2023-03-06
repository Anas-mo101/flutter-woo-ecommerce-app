class EndPoints {
  static String baseURL = 'https://mokhtar.shop/';
  static List<String> avoidCache = [
    login(),
    loginValid(),
    register(),
    orderTotals(),
    createComplain(),
    respondComplain(),
    getComplains(''),
    getComplain(''),
  ];

  /// WORDPRESS AUTH
  static login() => baseURL + 'wp-json/jwt-auth/v1/token';
  static loginValid() => baseURL + 'wp-json/jwt-auth/v1/token/validate';
  static register() => baseURL + 'wp-json/jwt-auth/v1/register';
  /// WooCommerce Products
  static wooProduct(String id) => baseURL + 'wp-json/wc/v3/products/' + id;
  static wooProducts({String search, String minPrice, String maxPrice, String page, String per_page,String category, String include}){
    String params = Uri(queryParameters: {
      'search': search,
      'max_price': minPrice,
      'min_price': maxPrice,
      'page': page,
      'per_page': per_page,
      'category': category,
      'include': include
    }).query;
    return baseURL + 'wp-json/wc/v3/products?' + params;
  }
  static wooProductVars(String id) => baseURL + 'wp-json/wc/v3/products/$id/variations';
  static wooCategories() => baseURL + 'wp-json/wc/v3/products/categories';

  static wooPaymentGateways() => baseURL + 'wp-json/wc/v3/payment_gateways';
  static wooShippingZone() => baseURL + 'wp-json/wc/v3/shipping/zones';
  static wooShippingMethods(String id) => baseURL + 'wp-json/wc/v3/shipping/zones/$id/methods';
  static wooCountryInfo(String id) => baseURL + '/wp-json/wc/v3/data/countries/$id';
  static utilityShippingMethods(String id) {
    String params = Uri(queryParameters: { 'zone_id': id }).query;
    return baseURL + 'wp-json/app-utility/v1/shipping-methods-rates?' + params;
  }


  static wooStoreTax() => baseURL + 'wp-json/wc/v3/taxes';
  static wooStoreCurrency() => baseURL + 'wp-json/wc/v3/data/currencies/current';

  static wooStoreCoupons() => baseURL + 'wp-json/wc/v3/coupons';

  static wooCreateProductReview() => baseURL + 'wp-json/wc/v3/products/reviews';
  static wooProductReview(String productId,{String page, String perPage}){
    String params = Uri(queryParameters: {
      'page': page,
      'per_page': perPage,
      'product': productId,
    }).query;
    return baseURL + 'wp-json/wc/v3/products/reviews?' + params;
  }

  static orderTotals() => baseURL + 'wp-json/app-utility/v1/totals';
  ///

  static final String baseURL2 = 'https://api.escuelajs.co/api/v1/';
  static product(String id) => baseURL2 + 'products/' + id;
  static products({String search, String category, String minPrice, String maxPrice, String offset, String limit}){
    String params = Uri(queryParameters: {
      'title': search,
      'category': category,
      'price_max': minPrice,
      'price_min': maxPrice,
      'offset': offset,
      'limit': limit,
    }).query;

    return baseURL2 + 'products/?' + params;
  }

  ///
  static createOrder(int userID) {
    String params = Uri(queryParameters: {
      'customer_id': userID.toString(),
    }).query;

    return baseURL + 'wp-json/wc/v3/orders?' + params;
  }

  static getOrder(int userID) {
    String params = Uri(queryParameters: {
      'customer_id': userID.toString(),
    }).query;

    return baseURL + 'wp-json/wc/v3/orders?' + params;
  }

  /// complains wp-json/app-utility/v1/ads/all
  static createComplain() => baseURL + 'wp-json/app-utility/v1/complain';
  static respondComplain() => baseURL + 'wp-json/app-utility/v1/complain/responed';
  static getComplains(String id) => baseURL + 'wp-json/app-utility/v1/complains?user_id=$id';
  static getComplain(String cid) => baseURL + 'wp-json/app-utility/v1/complain/single?complain_id=$cid';

  /// Ads
  static allAds() => baseURL + 'wp-json/app-utility/v1/ads/all';
  static ads() => baseURL + '/wp-json/app-utility/v1/ads';
  static adsSettings() => baseURL + 'wp-json/app-utility/v1/ads/settings';


  static bool isCacheable(String url){
    return avoidCache.firstWhere(
       (element) => url.contains(element), orElse: () => ''
    ) == '' ? true : false;
  }
}