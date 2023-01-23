import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'dart:typed_data';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class AppCacheManager {
  static const _CACHE_KEY = 'AppCacheKey';
  static const _MAX_NO_OF_CACHE_OBJECT = 50;
  static const _STALE_PERIOD = const Duration(days: 7);

  CacheManager _cacheManager;
  static AppCacheManager _instance;

  AppCacheManager._() {
    _cacheManager = CacheManager(Config(_CACHE_KEY, stalePeriod: _STALE_PERIOD, maxNrOfCacheObjects: _MAX_NO_OF_CACHE_OBJECT));
  }

  factory AppCacheManager() {
    _instance ??= AppCacheManager._();
    return _instance;
  }

  /// This method is responsible to return FileInfo and will also remove the file in case
  /// file validity is expired
  /// return null in case (Platform is Web, file doesn't exist, file validity is expired)
  Future<FileInfo> getFileInfoFromCache(String key, {bool ignoreMemCache = false}) async {
    /// No FileInfo will be returned in case of Web
    if (!kIsWeb) {
      var cachedFileInfo = await _cacheManager?.getFileFromCache(key, ignoreMemCache: ignoreMemCache);

      /// return null value when cache not found
      if (cachedFileInfo?.file == null) {
        return Future.value(null);
      }
      bool isValidityExpired = _isFileValidityExpired(cachedFileInfo);

      /// remove cached file if validity is expired
      if (isValidityExpired) {
        _cacheManager?.removeFile(key);
        return Future.value(null);
      }
      return Future.value(cachedFileInfo);
    }
    return Future.value(null);
  }

  /// This method is responsible to return FileInfo and will also remove the file in case
  /// file validity is expired
  /// return null in case (Platform is Web, file doesn't exist, file validity is expired)
  Future<dynamic> getJsonInfoFromCache(String key, {bool ignoreMemCache = false}) async {
    /// No FileInfo will be returned in case of Web
    print('ATTEMPTING TO FETCH $key FROM CACHE');
    if (!kIsWeb) {
      print('FETCHING $key FROM CACHE');
      var cachedFileInfo = await _cacheManager?.getFileFromCache(key, ignoreMemCache: ignoreMemCache);

      /// return null value when cache not found
      if (cachedFileInfo?.file == null) {
        print('NO CACHE $key IS EXPIRED');
        return Future.value(null);
      }
      bool isValidityExpired = _isFileValidityExpired(cachedFileInfo);

      /// remove cached file if validity is expired
      if (isValidityExpired) {
        print('CACHE $key IS EXPIRED');
        _cacheManager?.removeFile(key);
        return Future.value(null);
      }

      return json.decode(cachedFileInfo.file.readAsStringSync());
    }
    print('FAILED TO FETCH $key FROM CACHE');
    return Future.value(null);
  }

  /// method to check file validity
  bool _isFileValidityExpired(FileInfo cachedFileInfo) {
    return DateTime.now().isAfter(cachedFileInfo.validTill);
  }

  Future<bool> isFileValidityExpiredByUrl(String key, {bool ignoreMemCache = true}) async {
    var cachedFileInfo = await _cacheManager?.getFileFromCache(key, ignoreMemCache: ignoreMemCache);

    /// return null value when cache not found
    if (cachedFileInfo?.file == null) {
      print('NO CACHE AVAILABLE');
      return false;
    }

    print(cachedFileInfo.validTill);

    return DateTime.now().isBefore(cachedFileInfo.validTill);
  }

  /// This method is responsible for saving input stream into cache
  /// Web Platform not Supported, hence will return null
  Future cacheFile(String url, Uint8List bytes, int validTimeInDays) async {
    if (!kIsWeb) {
      /// Saving the response to File
      print('CACHING => $url for => $validTimeInDays days');
      await _cacheManager?.putFile(
        url,
        bytes,
        maxAge: Duration(days: validTimeInDays),
        fileExtension: 'json'
      );
      /// Finished saving the response to file
    }
  }


  Future<void> clearCache() {
    print('CACHING CLEAR');
    return _cacheManager?.emptyCache() ?? Future.value(null);
  }
}