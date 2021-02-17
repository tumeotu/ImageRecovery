import 'package:equatable/equatable.dart';
import 'package:image_recovery/modules/phananhtructuyen/models/media_phananh_model.dart';
import 'package:image_recovery/modules/phananhtructuyen/models/model.dart';

class PhanAnhViPhamState extends Equatable {
  final List<MediaPhanAnhModel> medias;
  final String soNha;
  final PhuongXaDanhMucModel phuongXaDanhMucSelected;
  final DuongDanhMucModel duongDanhMucSelected;
  final LinhVucHoSoModel linhVucHoSoSelected;
  final String noiDungPhanAnh;
  final String thongTinNguoiPhanAnh;
  final String message;
  final PhanAnhSubmitStatus submitStatus;

  const PhanAnhViPhamState(
      {this.medias,
      this.soNha,
      this.phuongXaDanhMucSelected,
      this.duongDanhMucSelected,
      this.linhVucHoSoSelected,
      this.noiDungPhanAnh,
      this.thongTinNguoiPhanAnh,
      this.message,
      this.submitStatus});

  PhanAnhViPhamState cloneWith(
          {medias,
          soNha,
          phuongXaDanhMucSelected,
          duongDanhMucSelected,
            linhVucHoSoSelected,
          noiDungPhanAnh,
          thongTinNguoiPhanAnh,
          message,
          submitStatus}) =>
      PhanAnhViPhamState(
          medias: medias ?? this.medias,
          soNha: soNha ?? this.soNha,
          phuongXaDanhMucSelected:
              phuongXaDanhMucSelected ?? this.phuongXaDanhMucSelected,
          duongDanhMucSelected:
              duongDanhMucSelected ?? this.duongDanhMucSelected,
          linhVucHoSoSelected:
          linhVucHoSoSelected ?? this.linhVucHoSoSelected,
          noiDungPhanAnh: noiDungPhanAnh ?? this.noiDungPhanAnh,
          thongTinNguoiPhanAnh:
              thongTinNguoiPhanAnh ?? this.thongTinNguoiPhanAnh,
          message: message ?? this.message,
          submitStatus: submitStatus ?? this.submitStatus);

  @override
  List<Object> get props => [
        this.medias,
        this.soNha,
        this.phuongXaDanhMucSelected,
        this.duongDanhMucSelected,
        this.linhVucHoSoSelected,
        this.noiDungPhanAnh,
        this.thongTinNguoiPhanAnh,
        this.message,
        this.submitStatus
      ];
}
