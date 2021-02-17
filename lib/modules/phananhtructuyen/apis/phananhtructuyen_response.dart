import 'package:get_it/get_it.dart';
import 'package:image_recovery/config_service.dart';
import 'package:image_recovery/constants.dart';
import 'package:image_recovery/modules/phananhtructuyen/apis/phananhtructuyen_datasource.dart';
import 'package:image_recovery/modules/phananhtructuyen/models/model.dart';
import 'package:image_recovery/modules/phananhtructuyen/models/phananh_tracuu_model.dart';
import 'package:image_recovery/utils/networks/network_datasource.dart';

class PhanAnhTrucTuyenResponse extends PhanAnhTrucTuyenDataSource {
  NetworkDataSource network;

  PhanAnhTrucTuyenResponse() {
    this.network = getIt.get<NetworkDataSource>();
  }

  @override
  Future<List<LoaiPhanAnhDM>> loaiPhanAnhDoThiGetAll() async {
    final url = BASE_URL + '/api/DanhMucPhanAnhTrucTuyen_GetAll';
    final reponseData = await network.get(url);
    final dataList = reponseData as List;
    final List<LoaiPhanAnhDM> list = dataList.map((item) {
      return LoaiPhanAnhDM.fromJson(item);
    }).toList();
    //await Future.delayed(Duration(seconds: 3));
    return list;
  }

  @override
  Future<List<DuongDanhMucModel>> danhMucDuongGetAll(String maPhuong) async {
    final url = BASE_URL + "/api/GetDMDuong/" + maPhuong;
    final reponseData = await network.get(url);
    final dataList = reponseData as List;
    final List<DuongDanhMucModel> list = dataList.map((item) {
      return DuongDanhMucModel.fromJson(item);
    }).toList();
    //await Future.delayed(Duration(seconds: 3));
    return list;
  }

  @override
  Future<List<PhuongXaDanhMucModel>> danhMucPhuongGetAll() async {
    final url = BASE_URL + '/api/GetDMPhuong';

    final reponseData = await network.get(url);
    final dataList = reponseData as List;
    final List<PhuongXaDanhMucModel> list = dataList.map((item) {
      return PhuongXaDanhMucModel.fromJson(item);
    }).toList();
    //await Future.delayed(Duration(seconds: 3));
    return list;
  }

  Future<PhanAnhTrucTuyenInsResult> phanAnhTrucTuyen(
      PhanAnhTrucTuyenInsParam param) async {
    final url = BASE_URL + '/api/PhanAnhTrucTuyenIns';

    final reponseData = await network.post(Uri.parse(url), body: param.toMap());
    final dataList = reponseData as Map<String, dynamic>;
    final result = PhanAnhTrucTuyenInsResult.fromJson(dataList);
    return result;
  }

  @override
  Future<List<PhanAnhTraCuuResult>> traCuuPhanAnh(
      PhanAnhTraCuuParam param) async {
    final url = BASE_URL + '/api/TraCuuPADoThi';

    var params = param.toMap();

    final reponseData = await network.post(Uri.parse(url), body: params);
    final dataList = reponseData as List;
    print(dataList);
    final List<PhanAnhTraCuuResult> list = dataList.map((item) {
      return PhanAnhTraCuuResult.fromJson(item);
    }).toList();
    //await Future.delayed(Duration(seconds: 3));
    return list;
  }

  @override
  Future<List<LinhVucHoSoModel>> danhMucLinhVucHoSoGetAll() async {
    final url = BASE_URL + "/api/GetAllLoaiViPham/";
    Map<String, String> param = {"LoaiPADT": "3"};
    final reponseData = await network.post(Uri.parse(url), body: param);
    final dataList = reponseData as List;
    final List<LinhVucHoSoModel> list = dataList.map((item) {
      return LinhVucHoSoModel.fromJson(item);
    }).toList();
    //await Future.delayed(Duration(seconds: 3));
    return list;
  }
}
