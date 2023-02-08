import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'package:camera/camera.dart';

import 'tflite_model_manager.dart';

class ImageDetectionSearch{

  var picker = ImagePicker();
  XFile image;
  List<CameraDescription> cameras;

  TfliteModelManager tmm = TfliteModelManager();

  Future getSearchImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    print("pickedFile: $pickedFile.path");
    if (pickedFile != null) {
      image = XFile(pickedFile.path);
      return await ImageCropper().cropImage(
          sourcePath: pickedFile.path,
          compressFormat: ImageCompressFormat.jpg,
          compressQuality: 100,
          uiSettings: [
            AndroidUiSettings(
                toolbarTitle: 'Cropper',
                toolbarColor: Colors.deepOrange,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.original,
                lockAspectRatio: false
            ),
            IOSUiSettings(title: 'Cropper'),
          ]
      ).then((value) => getPickedImageClassificationModel(pickedFile.path));
    } else {

    }
  }

  Future getSearchImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      image = XFile(pickedFile.path);
      return await ImageCropper().cropImage(
          sourcePath: pickedFile.path,
          compressFormat: ImageCompressFormat.jpg,
          compressQuality: 100,
          uiSettings: [
            AndroidUiSettings(
                toolbarTitle: 'Cropper',
                toolbarColor: Colors.deepOrange,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.original,
                lockAspectRatio: false
            ),
            IOSUiSettings(title: 'Cropper'),
          ]
      ).then((value) => getPickedImageClassificationModel(pickedFile.path));
    } else {

    }
  }

  void loadTFLiteModels() async {
    ///http://mokhtar.shop/wp-content/uploads/model_classification.tflite
    await tmm.loadModel();
     await Tflite.loadModel(
         model: 'assets/model_classification.tflite',
         labels: 'assets/labels.txt')
     .then((value) {
       print('load model ; $value');
     }).catchError((e){
        print('Error is : $e');
     });
  }

  Future<String> getPickedImageClassificationModel(String path) async {
    if(!tmm.isModelDownloaded) {
      print('model not loaded yet');
      return '';
    } ///

    var result = await Tflite.runModelOnImage(
      path: path,
      imageMean: 0,
      imageStd: 255,
    ).then((value) => value[0]['label'].toString());
    return result.toString();
  }

  Future<void> close() async {
    await Tflite.close();
  }
}
