import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';


class TfliteModelManager{
  bool _isModelDownloaded = false;
  bool _isLoading = true;

  bool get isModelDownloaded => _isModelDownloaded;
  bool get isLoading => _isLoading;

  Future<bool> _requestWritePermission() async {
    await Permission.storage.request();
    return await Permission.storage.request().isGranted;
  }

  // Future<bool> modelIsLoading() async {
  //   final appDocDir = await getApplicationDocumentsDirectory();
  //   final modelPath = appDocDir.path;
  //
  //   /// If exist return its path
  //   if(File(modelPath + '/model_classification.tflite').existsSync()){
  //     return true;
  //   }
  //
  //   return false;
  // }

  Future<String> loadModel() async {
    /// check if file exists
    final appDocDir = await getApplicationDocumentsDirectory();
    final modelPath = appDocDir.path;

    /// If exist return its path
    if(File(modelPath + '/model_classification.tflite').existsSync()){
      _isModelDownloaded = true;
      return modelPath;
    }

    /// If does not exist, download from web using url
    try{
      await downloadModel();
      return modelPath;
    }catch(e){
      throw Exception('Load model failed');
    }
  }

  Future<void> downloadModel() async {
    final url = 'http://mokhtar.shop/wp-content/uploads/model_classification.tflite';
    final labelUrl = 'http://mokhtar.shop/wp-content/uploads/labels.txt';
    bool hasPermission = await _requestWritePermission();
    if (!hasPermission) {
      print('No Write Permission');
      throw Exception('No Write Permission');
    }

    // gets the directory where we will download the file.
    final appDocDir = await getApplicationDocumentsDirectory();
    final modelPath = '${appDocDir.path}/model_classification.tflite';
    final labelPath = '${appDocDir.path}/label.txt';

    // downloads the file
    try{
      await Dio().download(url, modelPath, onReceiveProgress: (received, total) {
          final progress = (received / total) * 100;
          print('Downloading model: $progress');
      });

      await Dio().download(labelUrl, labelPath, onReceiveProgress: (received, total) {
        final progress = (received / total) * 100;
        print('Downloading label: $progress');
      });

      _isModelDownloaded = true;
      _isLoading = false;
    }catch(e){
      print('Model failed to download: $e');
      _isLoading = false;
      throw Exception('Model failed to download: $e');
    }
  }

}


