import 'dart:convert';
import 'package:http/http.dart' as http;
import 'data providers/cache_manager.dart';
import 'data_channel_decider.dart';
import 'endpoint.dart';

class AppDataProvider{

  Future<http.Response> apiCall(String method, String url, {Map headers, Object body}) async {
    switch(method){
      case 'get':
        return await http.get(Uri.parse(url), headers: headers);
      case 'post':
        return await http.post(Uri.parse(url), body: body, headers: headers);
      case 'update':
        return await http.put(Uri.parse(url), body: body, headers: headers);
      case 'delete':
        return await http.delete(Uri.parse(url), headers: headers);
    }
  }


  dynamic handleResponse(String method, String url, {Map headers, Object body}) async {
    // check for connectivity, if connected fetch from api, else fetch from cache, else throw Exception
    final channel = await DataChannelDecider.decideChannel(url);
    print('DATA FROM CHANNEL: $channel');
    if (channel == DataChannels.INTERNET) {
      final res = await apiCall(method, url, headers: headers, body: body);
      print('API RESPONSE: ${res.statusCode}');
      if (res.statusCode == 200) {
        // update cache - not for all endpoints
        if(EndPoints.isCacheable(url)){
          AppCacheManager().cacheFile(url, res.bodyBytes, 7);
        }
        print(json.decode(res.body));
        return json.decode(res.body);
      } else {
        print('API RESPONSE: FAILED');
        // in case wifi response fails, check if cache is available as backup
        if(EndPoints.isCacheable(url)){
          print('CHECKING BACKUP CACHE');
          if(await AppCacheManager().isFileValidityExpiredByUrl(url)){
            print('USING BACKUP CACHE');
            return await AppCacheManager().getJsonInfoFromCache(url).onError((error, stackTrace) => {
              print('BACKUP CACHE FAILED'),
              throw Exception('Cache fetching failed')
            });
          }
        }
        throw Exception('Response Failed');
      }
    } else if (channel == DataChannels.CACHE) {
      return await AppCacheManager().getJsonInfoFromCache(url).onError((error, stackTrace) => {
        print('CACHE RESPONSE: FAILED'),
        throw Exception('Cache fetching failed')
      });
    }
    print('NO DATA PROVIDER AVAILABLE');
    throw Exception('No API Available');
  }
}