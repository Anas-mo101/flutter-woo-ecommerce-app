import 'data providers/cache_manager.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

enum DataChannels {INTERNET, CACHE, NULL}

class DataChannelDecider{

  static Future<DataChannels> decideChannel(String url) async {
    DataChannels channelsFirstPrty = await isConnectedWifi();
    if(channelsFirstPrty == DataChannels.INTERNET){
      return channelsFirstPrty;
    }

    DataChannels channelsSecondPrty = await isValidCacheAvailable(url);
    if(channelsSecondPrty == DataChannels.NULL){
      return channelsSecondPrty;
    }

    if(channelsFirstPrty == channelsSecondPrty){
      return channelsFirstPrty;
    }

    return DataChannels.NULL;
  }

  static Future<DataChannels> isConnectedWifi() async {
    if (await DataConnectionChecker().hasConnection) {
      return DataChannels.INTERNET;
    }
    return DataChannels.CACHE;
  }

  static Future<DataChannels> isValidCacheAvailable(String url) async {
    /// check for cache availability by url
    if(await AppCacheManager().isFileValidityExpiredByUrl(url)){
      return DataChannels.CACHE;
    }
    return DataChannels.NULL;
  }
}