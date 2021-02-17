
import 'package:intl/intl.dart';

class TinTucCongAn_Lst_Result {
  final int id;
  final String tieuDe;
  final String noiDung;
  final String noiDungRutGon;
  final DateTime ngayGioPostTin;
  final int luotShare;
  final String hinhDaiDien;
  final int loaiTinTuc;
  final int luotLike;



  TinTucCongAn_Lst_Result(
      {this.id,
        this.tieuDe,
        this.noiDung,
        this.noiDungRutGon,
        this.ngayGioPostTin,
        this.luotShare,
        this.hinhDaiDien,
        this.loaiTinTuc,
        this.luotLike});

  factory TinTucCongAn_Lst_Result.fromJson(Map<String, dynamic> json) {
    final volumeInfo = json['volumeInfo'];

    return TinTucCongAn_Lst_Result(
        id: json['id'],
        tieuDe: json['tieuDe'],
        noiDung: json['noiDung'],
        noiDungRutGon: json['noiDungRutGon'],
        ngayGioPostTin:DateTime.parse(json['ngayGioPostTin']) ,
        luotShare: json['luotShare'],
        hinhDaiDien: json['hinhDaiDien'],
        loaiTinTuc: json['loaiTinTuc'],
        luotLike: json['luotLike']);
  }
}
