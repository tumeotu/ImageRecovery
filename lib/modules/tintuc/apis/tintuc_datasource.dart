import '../tintuc_imports.dart';

abstract class TinTucDataSource{
  Future<List<TinTucCongAn_Lst_Result>> getTinTucSuKien(String id,String donViThucHienID,String noiDung,String pageNum,String pageSize);
  Future<TinTucCongAn_Lst_Result> getTinTucChiTiet(int id);
}