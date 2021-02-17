import 'dart:collection';
import 'dart:io';
import 'dart:typed_data';

import 'package:get_it/get_it.dart';
import 'package:image_recovery/data/models/dashboard_models.dart';
import 'package:image_recovery/pages/DetectResult/Model/ImageResultDetect.dart';
import 'package:image_recovery/pages/RecoverImageResult/model/ImageResult.dart';
import 'package:image_recovery/pages/SoThuTu/Model/model/PostSTTResponse.dart';
import 'package:image_recovery/pages/SoThuTu/Model/model/sothutu.dart';
import 'package:image_recovery/utils/networks/network_datasource.dart';

import '../../../constants.dart';
import 'DetectDataSource.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:convert';

final getIt = GetIt.instance;
class DetectResponse extends DetectDatasource {
  NetworkDataSource network;
  DetectResponse() {
    this.network = getIt.get<NetworkDataSource>();
  }

  @override
  Future<List<ImageResultDetect>> recoveryImages(Uint8List oldImage, Uint8List newImage) async {
    try {
      final url = BASE_URL + '/api/v1/detect/image/multi';
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files.add(
          http.MultipartFile.fromBytes(
              'image',
              oldImage,
              filename: 'image'+1.toString()+'.jpg'
          )
      );
      request.files.add(
          http.MultipartFile.fromBytes(
              'image',
              newImage,
              filename: 'image'+1.toString()+'.jpg'
          )
      );
      var res = await request.send();
      var responseByteArray = await res.stream.toBytes();
      var datas=json.decode(utf8.decode(responseByteArray));
      List<ImageResultDetect> imagesDetect = new List<ImageResultDetect>();
      for(int i=0;i<datas.length;i++)
      {
        DetectDatasourceModel data =  DetectDatasourceModel.fromJson(datas[i]);
        ImageResultDetect image = new ImageResultDetect(data.image, data.age, data.gender, data.emotion);
        imagesDetect.add(image);
      }
      return imagesDetect;
    } catch (Exception) {
      print(Exception);
      return null;
    }
  }
}
