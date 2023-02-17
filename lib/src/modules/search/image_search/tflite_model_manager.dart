import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class TfliteModelManager{
  bool _isLoading = true;
  Map<String, double> _downloadProgress;

  bool get isLoading => _isLoading;
  double downloadProgress(String file) => _downloadProgress[file];

  Future<bool> modelRequirementsExists() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final modelPath = appDocDir.path;

    /// If exist return its path
    if(File('$modelPath/label.txt').existsSync() &&
        File('$modelPath/model_classification.tflite').existsSync()){
      return true;
    }

    return false;
  }

  Future<String> loadModel() async {
    /// check if file exists
    final appDocDir = await getApplicationDocumentsDirectory();
    final modelPath = appDocDir.path;

    /// If exist return its path
    if(File('$modelPath/label.txt').existsSync() && File('$modelPath/model_classification.tflite').existsSync()){
      return modelPath;
    }

    /// If does not exist, download from web using url
    try{
      await _downloadModel(modelPath);
      await _downloadLabel(modelPath);
      return modelPath;
    }catch(e){
      throw Exception('Load model failed');
    }
  }

  Future<void> _downloadModel(String appDocDir) async {
    _isLoading = true;
    final url = 'http://mokhtar.shop/wp-content/uploads/model_classification.tflite';
    try{
      // gets the directory where we will download the file.
      final modelPath = '$appDocDir/model_classification.tflite';

      if(File(modelPath).existsSync()){
        print('deleting old file');
        await File(modelPath).delete();
      }

      await Dio().download(url, modelPath, onReceiveProgress: (received, total) {
        final progress = (received / total);
        _downloadProgress['model'] = progress;
        print('Downloading model: $progress');
      });
      print('done downloading model file');

    }catch(e){
      print('Model failed to download: $e');
      throw Exception('Model failed to download: $e');
    }
    _isLoading = false;
  }

  Future<void> _downloadLabel(String appDocDir) async {
    _isLoading = true;
    final labelUrl = 'http://mokhtar.shop/wp-content/uploads/labels.txt';
    try{
      // gets the directory where we will download the file.
      final labelPath = '$appDocDir/label.txt';

      if(File(labelPath).existsSync()){
        print('deleting old file');
        await File(labelPath).delete();
      }

      print('downloading label file');

      await Dio().download(labelUrl, labelPath, onReceiveProgress: (received, total) {
        final progress = received / total;
        _downloadProgress['label'] = progress;
        print('Downloading label: $progress');
      });

      print('done downloading label file');
    }catch(e){
      print('Labels failed to download: $e');
      throw Exception('Model failed to download: $e');
    }
    _isLoading = false;
  }
}





