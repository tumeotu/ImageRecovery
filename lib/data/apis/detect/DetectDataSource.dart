import 'dart:convert';
import 'dart:io';

import 'dart:typed_data';

import 'package:image_recovery/pages/DetectResult/Model/ImageResultDetect.dart';
import 'package:image_recovery/pages/RecoverImageResult/model/ImageResult.dart';

abstract class DetectDatasource{
  Future<List<ImageResultDetect>> recoveryImages(Uint8List oldImage, Uint8List newImage);
}

class DetectDatasourceModel {
  Uint8List image;
  String age;
  String gender;
  String emotion;
  DetectDatasourceModel({this.image});

  DetectDatasourceModel.fromJson(Map<String, dynamic> json) {
    image = base64Decode(json['image']);
    age = json['age'].toString();
    gender = json['gender'];
    emotion = json['emotion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['emotion'] = this.emotion;
    return data;
  }
}