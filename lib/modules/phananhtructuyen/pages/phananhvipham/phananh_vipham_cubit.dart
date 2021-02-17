import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_recovery/modules/phananhtructuyen/apis/phananhtructuyen_datasource.dart';
import 'package:image_recovery/modules/phananhtructuyen/models/media_phananh_model.dart';
import 'package:image_recovery/modules/phananhtructuyen/models/model.dart';
import 'package:image_recovery/modules/phananhtructuyen/pages/phananhvipham/phananh_vipham.dart';

class PhanAnhViPhamCubit extends Cubit<PhanAnhViPhamState> {
  final PhanAnhTrucTuyenDataSource dataSource;
  final LoaiPhanAnhDM loaiPhanAnh;
  final LoaiViPham loaiViPham;

  PhanAnhViPhamCubit({this.dataSource, this.loaiPhanAnh, this.loaiViPham})
      : assert(dataSource != null),
        assert(loaiPhanAnh != null),
        assert(loaiViPham != null),
        super(const PhanAnhViPhamState());

  @override
  void dispose() {}

  void mediasSelected(List<MediaPhanAnhModel> medias) {
    print("mediasSelected ${medias.length}");
    emit(
      state.cloneWith(medias: medias),
    );
  }

  void soNhaChanged(String soNha) {
    print("soNhaChanged ${soNha}");
    emit(
      state.cloneWith(soNha: soNha),
    );
  }

  void phuongDanhMucSelected(PhuongXaDanhMucModel phuongxa) {
    print("phuongDanhMucSelected ${phuongxa}");
    emit(
      state.cloneWith(phuongXaDanhMucSelected: phuongxa),
    );
  }

  void duongDanhMucSelected(DuongDanhMucModel duong) {
    print("duongDanhMucSelected ${duong}");
    emit(
      state.cloneWith(duongDanhMucSelected: duong),
    );
  }

  void linhVucHoSoSelected(LinhVucHoSoModel linhVucHoSo) {
    print("linhVucHoSoSelected ${linhVucHoSo}");
    emit(
      state.cloneWith(linhVucHoSoSelected: linhVucHoSo),
    );
  }

  void noiDungPhanAnhChanged(String noiDungPhanAnh) {
    print("noiDungPhanAnhChanged ${noiDungPhanAnh}");
    emit(
      state.cloneWith(noiDungPhanAnh: noiDungPhanAnh),
    );
  }

  void thongTinNguoiPhanAnhChanged(String thongTinNguoiPhanAnh) {
    print("thongTinNguoiPhanAnhChanged ${thongTinNguoiPhanAnh}");
    emit(
      state.cloneWith(thongTinNguoiPhanAnh: thongTinNguoiPhanAnh),
    );
  }

  void submitPhanAnhViPham(bool isHoSo) async {
    String messaging = "";
    //validation

    if (isHoSo) {
      if (state.linhVucHoSoSelected == null) {
        messaging = "Chưa chọn lĩnh vực hồ sơ";
      } else if (state.noiDungPhanAnh == null ||
          state.noiDungPhanAnh.isEmpty == true) {
        messaging = "Chưa nhập nội dung phản ánh";
      }
    } else {
      if (state.soNha == null || state.soNha.isEmpty == true) {
        messaging = "Chưa nhập số nhà";
      } else if (state.noiDungPhanAnh == null ||
          state.noiDungPhanAnh.isEmpty == true) {
        messaging = "Chưa nhập nội dung phản ánh";
      } else if (state.thongTinNguoiPhanAnh == null ||
          state.thongTinNguoiPhanAnh.isEmpty == true) {
        messaging = "Chưa nhập thông tin người phản ánh";
      }
    }

    try {
      //show snackbar when validation here
      if (messaging.isNotEmpty == true) {
        emit(
          state.cloneWith(
              message: messaging, submitStatus: PhanAnhSubmitStatus.invalid),
        );
        await Future.delayed(Duration(seconds: 2));
        return;
      }

      emit(
        state.cloneWith(submitStatus: PhanAnhSubmitStatus.submissionInProgress),
      );

      PhanAnhTrucTuyenInsParam param = PhanAnhTrucTuyenInsParam();
      param.linhVucID = state.linhVucHoSoSelected?.loaiViPhamID ?? 0;
      param.soNha = state.soNha;
      param.phuongID = state.phuongXaDanhMucSelected.phuongID;
      param.tenPhuong = state.phuongXaDanhMucSelected.tenPhuong;
      param.duongID = state.duongDanhMucSelected.duongID;
      param.tenDuong = state.duongDanhMucSelected.tenDuong;
      param.noiDungPhanAnh = state.noiDungPhanAnh;
      param.dienThoaiNguoiPhanAnh = state.thongTinNguoiPhanAnh;
      param.platform = (Platform.isIOS) ? "iOS" : "Android";
      param.loaiViPhamID = this.loaiViPham.loaiViPhamID.toString();
      param.tenLoaiViPham = this.loaiViPham.tenLoaiViPham;
      param.loaiPhanAnh = this.loaiPhanAnh.loaiPhanAnhID.toString();

      switch (state.medias.length) {
        case 1:
          param.url1 = state.medias[0].urlFile;
          break;
        case 2:
          param.url1 = state.medias[0].urlFile;
          param.url2 = state.medias[1].urlFile;

          break;
        case 3:
          param.url1 = state.medias[0].urlFile;
          param.url2 = state.medias[1].urlFile;
          param.url3 = state.medias[2].urlFile;
          break;
      }
      var data = await this.dataSource.phanAnhTrucTuyen(param);
      if (data != null && data.thongBao?.isNotEmpty == true) {
        emit(
          state.cloneWith(
              submitStatus: PhanAnhSubmitStatus.submissionSuccess,
              message: data.thongBao),
        );
      } else {
        emit(state.cloneWith(
            submitStatus: PhanAnhSubmitStatus.submissionFailure));
      }
    } catch (e) {
      print(e.errMsg());
    } finally {
      emit(
        state.cloneWith(message: "", submitStatus: PhanAnhSubmitStatus.none),
      );
    }
  }
}
