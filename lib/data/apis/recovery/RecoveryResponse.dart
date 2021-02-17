import 'dart:collection';
import 'dart:io';
import 'dart:typed_data';

import 'package:get_it/get_it.dart';
import 'package:image_recovery/data/models/dashboard_models.dart';
import 'package:image_recovery/pages/RecoverImageResult/model/ImageResult.dart';
import 'package:image_recovery/pages/SoThuTu/Model/model/PostSTTResponse.dart';
import 'package:image_recovery/pages/SoThuTu/Model/model/sothutu.dart';
import 'package:image_recovery/utils/networks/network_datasource.dart';

import '../../../constants.dart';
import 'RecoveryDataSource.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:convert';

final getIt = GetIt.instance;
class RecoveryResponse extends RecoveryDatasource {
  NetworkDataSource network;
  RecoveryResponse() {
    this.network = getIt.get<NetworkDataSource>();
  }

  @override
  Future<List<ImageResult>> recoveryImages(List<ImageResult> images) async {
    try {
      final url = BASE_URL + '/api/v1/recover/image/list';
      var request = http.MultipartRequest('POST', Uri.parse(url));
      var token="eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJBdXRob3IiOjF9.ey-e4CHDHrXS5TaMlpcQFTrgS5dbJ-O2rz_9aTPbVxw8PdERxT8uBnT0eELMpYVQBgvzFgi7pohZhuq5QPj6ig";
      var param = {
        "Authorization":token
      };
      request.headers.addAll(param);
      for(int i=0;i<images.length;i++)
      {
        request.files.add(
            http.MultipartFile.fromBytes(
                'image',
                images[i].OldImage,
                filename: 'image'+i.toString()+'.jpg'
            )
        );
      }
      var res = await request.send();
      var responseByteArray = await res.stream.toBytes();
      var datas=json.decode(utf8.decode(responseByteArray));
      for(int i=0;i<datas.length;i++)
      {
        images[i].NewImage= RecoveryDatasourceModel.fromJson(datas[i]).image;
      }
      return images;
    } catch (Exception) {
      print("Recover Excepton"+Exception.toString());
      return null;
    }
  }
}
