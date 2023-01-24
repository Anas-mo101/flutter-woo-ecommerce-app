

class EndPoints {
  static final String baseURL = 'https://api.escuelajs.co/api/v1/';

  static product(String id) => baseURL + 'products/' + id;

  static products({String search, String category, String minPrice, String maxPrice, String offset, String limit}){
    String params = Uri(queryParameters: {
      'title': search,
      'category': category,
      'price_max': minPrice,
      'price_min': maxPrice,
      'offset': offset,
      'limit': limit,
    }).query;

    return baseURL + 'products/?' + params;
  }


  static List<String> avoidCache = [];

  static bool isCacheable(String url){
    return avoidCache.firstWhere(
       (element) => element == url, orElse: () => ''
    ) == '' ? true : false;
  }
}