import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'package:image_recovery/pages/RecoverImageResult/model/ImageResult.dart';

abstract class HistoryRecoveryDatasource{
  Future<List<HistoryDatasourceModel>> historyRecoverImages(int page, String Token);
  Future<ImageResult> historyRecoverDetailImages(int ID, String Token);
}

class HistoryDatasourceModel {
  int iD;
  int userID;
  Uint8List oldImage;
  Uint8List newImage;
  DateTime dateEdit;
  double currentWidth=100.0;
  double startWidth=40.0;
  double startDx;
  double dx=0.0;
  double minWidth=48.0;
  GlobalKey keyRed = GlobalKey();

  HistoryDatasourceModel(
  {this.iD, this.userID, this.oldImage, this.newImage, this.dateEdit});

  HistoryDatasourceModel.fromJson(Map<String, dynamic> json) {
  iD = json['ID'];
  userID = json['UserID'];
  oldImage = base64Decode(json['OldImage'].replaceAll(RegExp('\"'), ''));
  newImage = base64Decode(json['NewImage'].replaceAll(RegExp('\"'), ''));
  dateEdit = DateTime.parse(json['DateEdit'].toString());
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['ID'] = this.iD;
  data['UserID'] = this.userID;
  data['OldImage'] = this.oldImage;
  data['NewImage'] = this.newImage;
  data['DateEdit'] = this.dateEdit;
  return data;
  }
  }