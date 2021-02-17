import 'package:image_recovery/modules/giayphepxaydung/model/filegiayphep.dart';

class ThongTinGiayPheps {
  int id;
  String soGiayPhep;
  DateTime ngayCap;
  String diaChi;
  double gpSLat;
  double gpSLng;
  bool isPhanAnh;
  List<FileGiayPheps> fileGiayPheps;

  ThongTinGiayPheps(
      {this.id,
        this.soGiayPhep,
        this.ngayCap,
        this.diaChi,
        this.gpSLat,
        this.gpSLng,
        this.isPhanAnh,
        this.fileGiayPheps});

  ThongTinGiayPheps.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    soGiayPhep = json['soGiayPhep'];
    String value = json['ngayCap'];
    ngayCap = DateTime.parse(value);
    diaChi = json['diaChi'];
    gpSLat = json['gpS_Lat'];
    gpSLng = json['gpS_Lng'];
    isPhanAnh = json['isPhanAnh'];
    if (json['fileGiayPheps'] != null) {
      fileGiayPheps = new List<FileGiayPheps>();
      json['fileGiayPheps'].forEach((v) {
        fileGiayPheps.add(new FileGiayPheps.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['soGiayPhep'] = this.soGiayPhep;
    data['ngayCap'] = this.ngayCap.toString();
    data['diaChi'] = this.diaChi;
    data['gpS_Lat'] = this.gpSLat;
    data['gpS_Lng'] = this.gpSLng;
    data['isPhanAnh'] = this.isPhanAnh;
    if (this.fileGiayPheps != null) {
      data['fileGiayPheps'] =
          this.fileGiayPheps.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
