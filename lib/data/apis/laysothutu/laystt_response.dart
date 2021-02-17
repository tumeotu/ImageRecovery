import 'dart:collection';

import 'package:get_it/get_it.dart';
import 'package:image_recovery/data/models/dashboard_models.dart';
import 'package:image_recovery/pages/SoThuTu/Model/model/PostSTTResponse.dart';
import 'package:image_recovery/pages/SoThuTu/Model/model/sothutu.dart';
import 'package:image_recovery/utils/networks/network_datasource.dart';

import '../../../constants.dart';
import 'laystt_datasource.dart';

final getIt = GetIt.instance;

class LaySTTResponse extends LaySTTDataSource {
  NetworkDataSource network;
  LaySTTResponse() {
    this.network = getIt.get<NetworkDataSource>();
  }

  @override
  Future<List<Phieu>> getSoThuTu() async {
    try {
      final url = BASE_URL + '/api/App_sp_HANGDOI';
      var param = new Map<String, String>();
      final data = await network.get(Uri.parse(url).toString());
      var datas = data as List;
      print(datas);
      List<Phieu> lstMucDoHaiLong = [];
      for (var item in datas) {
        lstMucDoHaiLong.add(Phieu.fromJson(item));
      }
      return lstMucDoHaiLong;
    } catch (Exception) {
      print(Exception);
      return null;
    }
  }

  @override
  Future<STTResponse> postLaySoThuTu(
      int idQuay, String tenQuay, String soDienThoai) async {
    try {
      final url = BASE_URL + '/api/LaySoThuTu';
      var param = new Map<String, String>();
      param['tenQuay'] = tenQuay;
      param['idQuay'] = idQuay.toString();
      param['soDienThoai'] = soDienThoai;
      final datas = await network.post(Uri.parse(url), body: param);
      STTResponse result = new STTResponse();
      result = STTResponse.fromJson(datas);
      return result;
    } catch (Exception) {
      print(Exception);
      return null;
    }
  }
}
