import 'dart:convert';
import 'dart:typed_data';

import 'package:image_recovery/pages/RecoverImageResult/model/ImageResult.dart';

abstract class RecoveryDatasource{
  Future<List<ImageResult>> recoveryImages(List<ImageResult> images, String token);
}

class RecoveryDatasourceModel {
  Uint8List image;

  RecoveryDatasourceModel({this.image});

  RecoveryDatasourceModel.fromJson(Map<String, dynamic> json) {
    image = base64Decode(json['image'].replaceAll(RegExp('\"'), ''));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    return data;
  }
}