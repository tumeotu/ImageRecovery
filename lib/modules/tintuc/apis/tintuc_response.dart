import 'package:get_it/get_it.dart';
import 'package:image_recovery/utils/networks/network_datasource.dart';

import '../../../constants.dart';
import '../tintuc_imports.dart';

class TinTucResponce extends TinTucDataSource {
  NetworkDataSource network;

  TinTucResponce() {
    this.network = GetIt.instance.get<NetworkDataSource>();
  }

  @override
  Future<List<TinTucCongAn_Lst_Result>> getTinTucSuKien(
      String id,
      String donViThucHienID,
      String noiDung,
      String pageNum,
      String pageSize) async {
    try {
      final url = BASE_URL + '/api/DanhSachTinTucBinhThanh';

      var param = new Map<String, String>();
      if (id != null && id.isNotEmpty) param['ID'] = id;
      if (donViThucHienID != null && donViThucHienID.isNotEmpty)
        param['DonViThucHienID'] = donViThucHienID;
      if (noiDung != null && noiDung.isNotEmpty) param['NoiDung'] = noiDung;
      param['PageNum'] = pageNum;
      param['PageSize'] = pageSize;

      final data = await network.post(Uri.parse(url), body: param);
      var datas = data as List;
      print(datas);
      List<TinTucCongAn_Lst_Result> lstData = [];
      for (var item in datas) {
        lstData.add(TinTucCongAn_Lst_Result.fromJson(item));
      }
      return lstData;
    } catch (Exception) {
      print(Exception);
      return null;
    }
  }

  @override
  Future<TinTucCongAn_Lst_Result> getTinTucChiTiet(int id) async{
      try{
        final url = BASE_URL + '/api/TinTucBinhThanh_GetByID/'+id.toString();
        final data = await network.get(url);
        return TinTucCongAn_Lst_Result.fromJson(data);
      }catch(Exception){
        return null;
      }
  }
}
