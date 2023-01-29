class EndPoints {
  static String baseURL = 'https://mokhtar.shop/';
  static List<String> avoidCache = [
    login(),
    loginValid(),
    register()
  ];

  /// WORDPRESS AUTH
  static login() => baseURL + 'wp-json/jwt-auth/v1/token';
  static loginValid() => baseURL + 'wp-json/jwt-auth/v1/token/validate';
  static register() => baseURL + 'wp-json/jwt-auth/v1/register';
  /// WooCommerce Products
  static wooProduct(String id) => baseURL + 'wp-json/wc/v3/products/' + id;
  static wooProducts({String search, String minPrice, String maxPrice, String page, String per_page,String category}){
    String params = Uri(queryParameters: {
      'search': search,
      'max_price': minPrice,
      'min_price': maxPrice,
      'page': page,
      'per_page': per_page,
      'category': category
    }).query;
    return baseURL + 'wp-json/wc/v3/products?' + params;
  }
  static wooCategories() => baseURL + 'wp-json/wc/v3/products/categories';
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

  static bool isCacheable(String url){
    return avoidCache.firstWhere(
       (element) => element == url, orElse: () => ''
    ) == '' ? true : false;
  }
}