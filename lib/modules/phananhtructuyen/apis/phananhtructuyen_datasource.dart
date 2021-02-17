import 'package:image_recovery/modules/phananhtructuyen/models/model.dart';
import 'package:image_recovery/modules/phananhtructuyen/models/phananh_tracuu_model.dart';

abstract class PhanAnhTrucTuyenDataSource {
  ///Danh mục phản ánh đô thị
  Future<List<LoaiPhanAnhDM>> loaiPhanAnhDoThiGetAll();

  ///Danh mục phường xã
  Future<List<PhuongXaDanhMucModel>> danhMucPhuongGetAll();

  ///Danh mục đường
  Future<List<DuongDanhMucModel>> danhMucDuongGetAll(String maPhuong);

  ///Danh mục lĩnh vực hồ sơ
  Future<List<LinhVucHoSoModel>> danhMucLinhVucHoSoGetAll();

  ///gửi phản ánh
  Future<PhanAnhTrucTuyenInsResult> phanAnhTrucTuyen(
      PhanAnhTrucTuyenInsParam param);

  ///gửi phản ánh
  Future<List<PhanAnhTraCuuResult>> traCuuPhanAnh(
      PhanAnhTraCuuParam param);
}
