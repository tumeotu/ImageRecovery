class Phieu {
  int idx;
  String ten;
  int tinhTrang;
  int khuVucIdx;
  String loai;
  String sott;
  int manHinhIdx;
  String noiDungTinNhan;
  String dauSoSMS;

  Phieu(
      {this.idx,
      this.ten,
      this.tinhTrang,
      this.khuVucIdx,
      this.loai,
      this.sott,
      this.manHinhIdx,
      this.noiDungTinNhan,
      this.dauSoSMS});
  Phieu.fromJson(Map<String, dynamic> json) {
    idx = json['idx'];
    ten = json['ten'];
    tinhTrang = json['tinhTrang'];
    khuVucIdx = json['khuVuc_Idx'];
    loai = json['loai'];
    sott = json['sott'];
    manHinhIdx = json['manHinh_Idx'];
    noiDungTinNhan = json['noiDungTinNhan'];
    dauSoSMS = json['dauSoSMS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idx'] = this.idx;
    data['ten'] = this.ten;
    data['tinhTrang'] = this.tinhTrang;
    data['khuVuc_Idx'] = this.khuVucIdx;
    data['loai'] = this.loai;
    data['sott'] = this.sott;
    data['manHinh_Idx'] = this.manHinhIdx;
    data['noiDungTinNhan'] = this.noiDungTinNhan;
    data['dauSoSMS'] = this.dauSoSMS;
    return data;
  }
}
