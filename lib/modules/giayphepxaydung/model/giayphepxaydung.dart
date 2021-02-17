import 'package:image_recovery/modules/giayphepxaydung/model/phananhxaydungkp.dart';
import 'package:image_recovery/modules/giayphepxaydung/model/thongtingiayphep.dart';

class GiayPhepXayDung{
  List<ThongTinGiayPheps> thongTinGiayPheps;
  List<PhanAnhXayDungKPs> phanAnhXayDungKPs;
  GiayPhepXayDung({this.thongTinGiayPheps, this.phanAnhXayDungKPs});

  GiayPhepXayDung.fromJson(Map<String, dynamic> json) {
    if (json['thongTinGiayPheps'] != null) {
      thongTinGiayPheps = new List<ThongTinGiayPheps>();
      json['thongTinGiayPheps'].forEach((v) {
        thongTinGiayPheps.add(new ThongTinGiayPheps.fromJson(v));
      });
    }
    if (json['phanAnhXayDungKPs'] != null) {
      phanAnhXayDungKPs = new List<PhanAnhXayDungKPs>();
      json['phanAnhXayDungKPs'].forEach((v) {
        phanAnhXayDungKPs.add(new PhanAnhXayDungKPs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.thongTinGiayPheps != null) {
      data['thongTinGiayPheps'] =
          this.thongTinGiayPheps.map((v) => v.toJson()).toList();
    }
    if (this.phanAnhXayDungKPs != null) {
      data['phanAnhXayDungKPs'] =
          this.phanAnhXayDungKPs.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
