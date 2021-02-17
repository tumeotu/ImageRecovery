class PhanAnhTraCuuResult {
  int phanAnhID;
  String viTri;
  String gpSLat;
  String gpSLng;
  String noiDungPhanAnh;
  DateTime thoiGianPhanAnh;
  String urL1;
  String urL2;
  String urL3;
  String noiDungXuLy;
  String tenDonViXuLy;
  String sobb;
  DateTime ngayLapBB;
  String fileBB;
  String noiDungXLBB;
  String soqd;
  DateTime ngayLapQD;
  String fileQD;
  String noiDungXLQD;
  String tenChuViPham;
  int tinhTrangID;
  String tenTinhTrang;
  String noiDungBaoCaoSauXL;
  String urlBaoCaoSauXL;
  String tenNguoiBaoCao;
  int soLuotLike;
  String tenLoaiPhanAnh;
  String tenLoaiViPham;
  bool isHoSo;
  bool isXuLyLai;
  bool isConHan;
  bool isPhanAnhNguoiDan;
  String loaiPhanAnh;

  PhanAnhTraCuuResult(
      {this.phanAnhID,
      this.viTri,
      this.gpSLat,
      this.gpSLng,
      this.noiDungPhanAnh,
      this.thoiGianPhanAnh,
      this.urL1,
      this.urL2,
      this.urL3,
      this.noiDungXuLy,
      this.tenDonViXuLy,
      this.sobb,
      this.ngayLapBB,
      this.fileBB,
      this.noiDungXLBB,
      this.soqd,
      this.ngayLapQD,
      this.fileQD,
      this.noiDungXLQD,
      this.tenChuViPham,
      this.tinhTrangID,
      this.tenTinhTrang,
      this.noiDungBaoCaoSauXL,
      this.urlBaoCaoSauXL,
      this.tenNguoiBaoCao,
      this.soLuotLike,
      this.tenLoaiPhanAnh,
      this.tenLoaiViPham,
      this.isHoSo,
      this.isXuLyLai,
      this.isConHan,
      this.isPhanAnhNguoiDan,
      this.loaiPhanAnh});

  PhanAnhTraCuuResult.fromJson(Map<String, dynamic> json) {
    phanAnhID = json['phanAnhID'] ?? 0;
    viTri = json['viTri'] ?? '';
    gpSLat = json['gpS_lat'] ?? '';
    gpSLng = json['gpS_lng'] ?? '';
    noiDungPhanAnh = json['noiDungPhanAnh'] ?? '';
    thoiGianPhanAnh = DateTime.parse(json['thoiGianPhanAnh']) ?? null;
    urL1 = json['urL1'] ?? '';
    urL2 = json['urL2'] ?? '';
    urL3 = json['urL3'] ?? '';
    noiDungXuLy = json['noiDungXuLy'] ?? '';
    tenDonViXuLy = json['tenDonViXuLy'] ?? '';
    sobb = json['sobb'] ?? '';
    ngayLapBB = (json['ngayLapBB'] != null) ?  DateTime.parse(json['ngayLapBB']) : null;
    fileBB = json['fileBB'] ?? '';
    noiDungXLBB = json['noiDungXLBB'] ?? '';
    soqd = json['soqd'] ?? '';
    ngayLapQD = (json['ngayLapQD'] != null) ?  DateTime.parse(json['ngayLapQD']) : null;
    fileQD = json['fileQD'] ?? '';
    noiDungXLQD = json['noiDungXLQD'] ?? '';
    tenChuViPham = json['tenChuViPham'] ?? '';
    tinhTrangID = json['tinhTrangID'] ?? 0;
    tenTinhTrang = json['tenTinhTrang'] ?? '';
    noiDungBaoCaoSauXL = json['noiDungBaoCaoSauXL'] ?? '';
    urlBaoCaoSauXL = json['urlBaoCaoSauXL'] ?? '';
    tenNguoiBaoCao = json['tenNguoiBaoCao'] ?? '';
    soLuotLike = json['soLuotLike'] ?? 0;
    tenLoaiPhanAnh = json['tenLoaiPhanAnh'] ?? '';
    tenLoaiViPham = json['tenLoaiViPham'] ?? '';
    isHoSo = json['isHoSo'] ?? '';
    isXuLyLai = json['isXuLyLai'] ?? false;
    isConHan = json['isConHan'] ?? false;
    isPhanAnhNguoiDan = json['isPhanAnhNguoiDan'] ?? false;
    loaiPhanAnh = json['loaiPhanAnh'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phanAnhID'] = this.phanAnhID;
    data['viTri'] = this.viTri;
    data['gpS_lat'] = this.gpSLat;
    data['gpS_lng'] = this.gpSLng;
    data['noiDungPhanAnh'] = this.noiDungPhanAnh;
    data['thoiGianPhanAnh'] = this.thoiGianPhanAnh;
    data['urL1'] = this.urL1;
    data['urL2'] = this.urL2;
    data['urL3'] = this.urL3;
    data['noiDungXuLy'] = this.noiDungXuLy;
    data['tenDonViXuLy'] = this.tenDonViXuLy;
    data['sobb'] = this.sobb;
    data['ngayLapBB'] = this.ngayLapBB;
    data['fileBB'] = this.fileBB;
    data['noiDungXLBB'] = this.noiDungXLBB;
    data['soqd'] = this.soqd;
    data['ngayLapQD'] = this.ngayLapQD;
    data['fileQD'] = this.fileQD;
    data['noiDungXLQD'] = this.noiDungXLQD;
    data['tenChuViPham'] = this.tenChuViPham;
    data['tinhTrangID'] = this.tinhTrangID;
    data['tenTinhTrang'] = this.tenTinhTrang;
    data['noiDungBaoCaoSauXL'] = this.noiDungBaoCaoSauXL;
    data['urlBaoCaoSauXL'] = this.urlBaoCaoSauXL;
    data['tenNguoiBaoCao'] = this.tenNguoiBaoCao;
    data['soLuotLike'] = this.soLuotLike;
    data['tenLoaiPhanAnh'] = this.tenLoaiPhanAnh;
    data['tenLoaiViPham'] = this.tenLoaiViPham;
    data['isHoSo'] = this.isHoSo;
    data['isXuLyLai'] = this.isXuLyLai;
    data['isConHan'] = this.isConHan;
    data['isPhanAnhNguoiDan'] = this.isPhanAnhNguoiDan;
    data['loaiPhanAnh'] = this.loaiPhanAnh;
    return data;
  }
}

class PhanAnhTraCuuParam {
  final String tuNgay;
  final String denNgay;
  final int phuongID;
  final int duongID;
  final String loaiXuLy;
  final String loaiViPham;
  final String loaiPhanAnh;
  final String tinhTrang;
  final bool isByImei;
  final String imei;
  final bool isAppPhanAnhDoThi;
  final int pageIndex;
  final int pageSize;

  PhanAnhTraCuuParam({
    this.tuNgay,
    this.denNgay,
    this.phuongID,
    this.duongID,
    this.loaiXuLy,
    this.loaiViPham,
    this.loaiPhanAnh,
    this.tinhTrang,
    this.isByImei,
    this.imei,
    this.isAppPhanAnhDoThi,
    this.pageIndex,
    this.pageSize,
  });

  Map<String, String> toMap() {
    return {
      'tuNgay': this.tuNgay ?? "",
      'denNgay': this.denNgay ?? "",
      'phuongID': (this.phuongID ?? 0).toString(),
      'duongID': (this.duongID ?? 0).toString(),
      'loaiXuLy': this.loaiXuLy ?? "",
      'loaiViPham': this.loaiViPham ?? "",
      'loaiPhanAnh': this.loaiPhanAnh ?? "",
      'tinhTrang': this.tinhTrang ?? "",
      'isByImei': (this.isByImei ?? false).toString(),
      'imei': this.imei ?? "",
      'isAppPhanAnhDoThi': (this.isAppPhanAnhDoThi ?? false).toString(),
      'pageIndex': (this.pageIndex ?? 0).toString(),
      'pageSize': (this.pageSize ?? 0).toString(),
    };
  }

  @override
  String toString() {
    // TODO: implement toString
    return this.pageIndex.toString() + this.pageSize.toString();
  }
}
