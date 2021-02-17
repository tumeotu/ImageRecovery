

class LinhVucHoSoModel {
  int loaiViPhamID;
  String tenLoaiViPham;
  String toaDoHinh1;
  String toaDoHinh2;

  LinhVucHoSoModel(
      {this.loaiViPhamID,
        this.tenLoaiViPham,
        this.toaDoHinh1,
        this.toaDoHinh2});

  LinhVucHoSoModel.fromJson(Map<String, dynamic> json) {
    loaiViPhamID = json['loaiViPhamID'];
    tenLoaiViPham = json['tenLoaiViPham'];
    toaDoHinh1 = json['toaDoHinh1'];
    toaDoHinh2 = json['toaDoHinh2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loaiViPhamID'] = this.loaiViPhamID;
    data['tenLoaiViPham'] = this.tenLoaiViPham;
    data['toaDoHinh1'] = this.toaDoHinh1;
    data['toaDoHinh2'] = this.toaDoHinh2;
    return data;
  }
}