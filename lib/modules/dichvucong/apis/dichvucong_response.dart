import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_recovery/modules/dichvucong/models/dichvucong_model.dart';
import 'package:image_recovery/utils/networks/network_datasource.dart';

import '../../../constants.dart';
import 'dichvucong_datasource.dart';

class DichVuCongResponse extends DichVuCongDataSource {
  @override
  Future<List<DVC_ThuTuc>> DM_ThuTuc_LstByPhanLoai(int pageNum, int pageSize,
      {String maLinhVuc, int phanLoai, String keyWord}) async {
    // TODO: implement DM_ThuTuc_LstByPhanLoai
    try {
      print(maLinhVuc);
      final url = BASE_URL + '/api/DM_ThuTuc_ByLinhVuc';
      var param = new Map<String, String>();
      param['PhanLoai'] = phanLoai.toString();
      if (keyWord != null) param['KeySearch'] = keyWord;
      if (maLinhVuc != null) param['MaLinhVuc'] = maLinhVuc;
      param['PageNum'] = pageNum.toString();
      param['PageSize'] = pageSize.toString();

      final data = await GetIt.instance
          .get<NetworkDataSource>()
          .post(Uri.parse(url), body: param);

      var dataResult = data as List;
      print(dataResult);
      List<DVC_ThuTuc> lstData = [];
      for (var item in dataResult) {
        lstData.add(DVC_ThuTuc.fromJson(item));
      }
      return lstData;
    } catch (error) {
      print('DM_ThuTuc_LstByPhanLoai $error');
      return null;
    }
  }

  @override
  Future<List<DVC_LinhVuc>> DM_LinhVuc() async {
    try {
      final url = BASE_URL + '/api/DM_LinhVuc';

      final data = await GetIt.instance.get<NetworkDataSource>().get(url);

      var dataResult = data as List;
      print(dataResult);
      List<DVC_LinhVuc> lstData = [];
      for (var item in dataResult) {
        lstData.add(DVC_LinhVuc.fromJson(item));
      }
      return lstData;
    } catch (error) {
      print('DM_LinhVuc $error');
      return null;
    }
  }

  @override
  Future<List<DVC_LinhVuc>> DM_LinhVuc_ByDVC(bool isDVC) async {
    try {
      final url = BASE_URL + '/api/DM_LinhVuc/' + (isDVC ? "1" : "0");

      final data = await GetIt.instance.get<NetworkDataSource>().get(url);

      var dataResult = data as List;
      print(dataResult);
      List<DVC_LinhVuc> lstData = [];
      for (var item in dataResult) {
        lstData.add(DVC_LinhVuc.fromJson(item));
      }
      return lstData;
    } catch (error) {
      print('DM_LinhVuc $error');
      return null;
    }
  }

  @override
  Future<DVC_ThuTuc_Detail> DM_ThuTuc_Detail(String thuTucID) async {
    try {
      final url = BASE_URL + '/api/DM_ThuTuc_Detail/' + thuTucID;

      final data = await GetIt.instance.get<NetworkDataSource>().get(url);
      print(data);
      var dataResult = DVC_ThuTuc_Detail.fromJson(data);
      return dataResult;
    } catch (error) {
      print('DM_ThuTuc_Detail $error');
      return null;
    }
  }
}
