import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';


class TfliteModelManager{
  bool _isModelDownloaded = false;

  get isModelDownloaded => _isModelDownloaded;

  Future<bool> _requestWritePermission() async {
    await Permission.storage.request();
    return await Permission.storage.request().isGranted;
  }

  Future<void> loadModel() async {
    /// check if file exists
    final appDocDir = await getApplicationDocumentsDirectory();
    final modelPath = '${appDocDir.path}/model_classification.tflite';

    /// If exist return its path
    if(File(modelPath).existsSync()){
      _isModelDownloaded = true;
      return modelPath;
    }

    /// If does not exist, download from web using url
    try{
      await downloadModel();
    }catch(e){
      throw Exception('Load model failed');
    }
  }

  Future<void> downloadModel() async {
    final url = 'http://mokhtar.shop/wp-content/uploads/2023/02/model_classification.zip';
    bool hasPermission = await _requestWritePermission();
    if (!hasPermission) {
      print('No Write Permission');
      throw Exception('No Write Permission');
    }

    // gets the directory where we will download the file.
    final appDocDir = await getApplicationDocumentsDirectory();
    final modelPath = '${appDocDir.path}/model_classification.tflite';

    // downloads the file
    try{
      await Dio().download(url, modelPath, onReceiveProgress: (received, total) {
          final progress = (received / total) * 100;
          print('Downloading: $progress');

        }
      );

      _isModelDownloaded = true;
    }catch(e){
      throw Exception('No Write Permission');
    }
  }

}


