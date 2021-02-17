import 'dart:collection';

import 'package:get_it/get_it.dart';
import 'package:image_recovery/data/models/dashboard_models.dart';
import 'package:image_recovery/pages/SoThuTu/Model/model/PostSTTResponse.dart';
import 'package:image_recovery/pages/SoThuTu/Model/model/sothutu.dart';
import 'package:image_recovery/utils/networks/network_datasource.dart';

import '../../../constants.dart';
import 'dashboard_datasource.dart';

final getIt = GetIt.instance;

class DashboardResponce extends DashboardDataSource {
  NetworkDataSource network;
  DashboardResponce() {
    this.network = getIt.get<NetworkDataSource>();
  }


  @override
  Future<List<MucDoHaiLong>> getMucDoHaiLong() async {
    try {
      final url = BASE_URL + '/api/ThongKeMucDoHaiLong';
      var param = new Map<String, String>();
      param['UserMGHaiLong'] = 'hocmon';
      param['UserDatDai'] = 'vpdk.hocmon';
      final data = await network.post(Uri.parse(url), body: param);
      var datas = data as List;
      print(datas);
      List<MucDoHaiLong> lstMucDoHaiLong = [];
      for (var item in datas) {
        lstMucDoHaiLong.add(MucDoHaiLong.fromJson(item));
      }
      return lstMucDoHaiLong;
    } catch (Exception) {
      print(Exception);
      return null;
    }
  }

  @override
  Future<ThongKeHoSo_Tong> getHoSoDaXuLy() async {
    try {
      final url = BASE_URL + '/api/ThongKeHoSoDaXuLy_tong';
      final data = await network.get(url);
      print(data);
      var datas = ThongKeHoSo_Tong.fromJson(data);
      return datas;
    } catch (Exception) {
      print(Exception);
      return null;
    }
  }

  @override
  Future<List<ThongKeHoSo_List>> thongKeHoSoDaXuLy_List(String loaiTK)async {
    try {
      final url = BASE_URL + '/api/ThongKeHoSoDaXuLy_List';
      var param = new Map<String, String>();
      param['type'] = loaiTK;
      final data = await network.post(Uri.parse(url), body: param);
      var datas = data as List;
      print(datas);
      List<ThongKeHoSo_List> result = [];
      for (var item in datas) {
        result.add(ThongKeHoSo_List.fromJson(item));
      }
      return result;
    } catch (Exception) {
      print(Exception);
      return null;
    }
  }


}
