import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:get_it/get_it.dart';
import 'package:image_recovery/data/models/dashboard_models.dart';
import 'package:image_recovery/pages/RecoverImageResult/model/ImageResult.dart';
import 'package:image_recovery/pages/SoThuTu/Model/model/PostSTTResponse.dart';
import 'package:image_recovery/pages/SoThuTu/Model/model/sothutu.dart';
import 'package:image_recovery/utils/networks/network_datasource.dart';

import '../../../constants.dart';
import 'package:http/http.dart' as http;
import 'HistoryDataSource.dart';

final getIt = GetIt.instance;
class  HistoryRecoveryResponse extends  HistoryRecoveryDatasource {
  NetworkDataSource network;
  HistoryRecoveryResponse() {
    this.network = getIt.get<NetworkDataSource>();
  }

  @override
  Future<List<HistoryDatasourceModel>> historyRecoverImages(int page, String Token) async {
    try {
      var param = {
        "PageNum":page.toString(),
        "PageSize":100.toString()
      };
      var uri =
      Uri.http(BASE_URL.replaceAll("http://", ""),'/api/v1/user/history', param);
      var response = await http.get(uri, headers: {
        HttpHeaders.authorizationHeader: '$Token',
        HttpHeaders.contentTypeHeader: 'application/json',
      });
      var datas=json.decode(utf8.decode(response.bodyBytes));
      List<HistoryDatasourceModel> images = [];
      for (var item in datas) {
        images.add(HistoryDatasourceModel.fromJson(item));
      }
      return images;
    } catch (Exception) {
      print(Exception);
      return null;
    }
  }

  @override
  Future<ImageResult> historyRecoverDetailImages(int ID, String Token) async {
    try {
      var param = {
        "ID":ID.toString()
      };
      var uri =
      Uri.http(BASE_URL.replaceAll("http://", ""),'/api/v1/user/history_detail', param);
      var response = await http.get(uri, headers: {
        HttpHeaders.authorizationHeader: '$Token',
        HttpHeaders.contentTypeHeader: 'application/json',
      });
      var datas=json.decode(utf8.decode(response.bodyBytes));
      ImageResult imageDetail = null;
      for (var item in datas) {
        HistoryDatasourceModel image= HistoryDatasourceModel.fromJson(item);
        imageDetail=new ImageResult(image.oldImage, image.newImage);
      }
      return imageDetail;
    } catch (Exception) {
      print(Exception);
      return null;
    }
  }
}
