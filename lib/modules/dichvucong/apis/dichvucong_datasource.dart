import 'package:flutter/material.dart';
import 'package:image_recovery/modules/dichvucong/models/dichvucong_model.dart';


abstract class DichVuCongDataSource{
  Future<List<DVC_ThuTuc>> DM_ThuTuc_LstByPhanLoai(int pageNum,int pageSize,{String maLinhVuc,int phanLoai, String keyWord});
  Future<List<DVC_LinhVuc>> DM_LinhVuc();
  Future<List<DVC_LinhVuc>> DM_LinhVuc_ByDVC(bool isDVC);
  Future<DVC_ThuTuc_Detail> DM_ThuTuc_Detail(String thuTucID);
}

