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
    }
  }

  Future loadTFLiteModels(String modelPath) async {
     await Tflite.loadModel(
        model: modelPath + '/model_classification.tflite',
        labels: modelPath + '/label.txt',
        isAsset: false
     ).then((value) {
        print('load model ; $value');
     }).catchError((e){
        print('Error is : $e');
     });
  }

  Future<String> getPickedImageClassificationModel(String path) async {
    var result = await Tflite.runModelOnImage(
      path: path,
      imageMean: 0,
      imageStd: 255,
    ).then((value) => value != null && value.length > 0 ? value[0]['label'].toString() : '');
    return result.toString();
  }

  Future<void> close() async {
    await Tflite.close();
  }
}
