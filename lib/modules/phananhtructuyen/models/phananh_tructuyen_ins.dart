class PhanAnhTrucTuyenInsParam {
  int giayPhepXayDungID;
  String soNha;
  int phuongID;
  String tenPhuong;
  int duongID;
  String tenDuong;
  String gps_lat;
  String gps_lng;
  String noiDungPhanAnh;
  String loaiViPhamID;
  String tenLoaiViPham;
  String dienThoaiNguoiPhanAnh;
  String url1;
  String url2;
  String url3;
  String imei;
  String platform;
  String viTriLocation;
  String loaiPhanAnh;
  int linhVucID;


  Map<String, String> toMap() {
    return {
      'giayPhepXayDungID': this.giayPhepXayDungID?.toString() ?? "0",
      'soNha': this.soNha,
      'phuongID': this.phuongID.toString(),
      'tenPhuong': this.tenPhuong,
      'duongID': this.duongID.toString(),
      'tenDuong': this.tenDuong,
      'gps_lat': this.gps_lat ?? "0",
      'gps_lng': this.gps_lng ?? "0",
      'noiDungPhanAnh': this.noiDungPhanAnh,
      'loaiViPhamID': this.loaiViPhamID,
      'tenLoaiViPham': this.tenLoaiViPham,
      'dienThoaiNguoiPhanAnh': this.dienThoaiNguoiPhanAnh ?? "",
      'url1': this.url1 ?? "",
      'url2': this.url2 ?? "",
      'url3': this.url3 ?? "",
      'imei': this.imei ?? "",
      'platform': this.platform,
      'viTriLocation': this.viTriLocation ?? "",
      'loaiPhanAnh': this.loaiPhanAnh ?? "",
      'linhVucID': this.linhVucID.toString() ?? "0"
    };
  }
}

class PhanAnhTrucTuyenInsResult {
  final int id;
  final String thongBao;
  final String token;
  const PhanAnhTrucTuyenInsResult({this.id,this.thongBao,this.token});

  factory PhanAnhTrucTuyenInsResult.fromJson(Map<String, dynamic> json) =>

      PhanAnhTrucTuyenInsResult(
        id: json['id'],
        thongBao: json['thongBao'],
        token: json['token']);
}
