import 'package:image_recovery/data/models/dashboard_models.dart';
import 'package:image_recovery/pages/SoThuTu/Model/model/PostSTTResponse.dart';
import 'package:image_recovery/pages/SoThuTu/Model/model/sothutu.dart';

abstract class LaySTTDataSource{
  Future<STTResponse> postLaySoThuTu(int idQuay, String tenQuay, String soDienThoai);
  Future<List<Phieu>> getSoThuTu();
}

