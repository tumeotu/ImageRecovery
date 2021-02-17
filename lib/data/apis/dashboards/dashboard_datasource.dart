
import 'package:image_recovery/data/models/dashboard_models.dart';
import 'package:image_recovery/pages/SoThuTu/Model/model/PostSTTResponse.dart';
import 'package:image_recovery/pages/SoThuTu/Model/model/sothutu.dart';

abstract class DashboardDataSource{
  Future<List<MucDoHaiLong>> getMucDoHaiLong();
  Future<ThongKeHoSo_Tong> getHoSoDaXuLy();
  Future<List<ThongKeHoSo_List>> thongKeHoSoDaXuLy_List(String loaiTK);
}