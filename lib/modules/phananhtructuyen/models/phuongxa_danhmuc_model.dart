class PhuongXaDanhMucModel {
  final int id;
  final int phuongID;
  final String tenPhuong;
  final String maPhuongXa;
  final String maPhuong;

  const PhuongXaDanhMucModel(
      {this.id, this.phuongID, this.tenPhuong, this.maPhuongXa, this.maPhuong});

  factory PhuongXaDanhMucModel.fromJson(Map<String, dynamic> json) {
    return PhuongXaDanhMucModel(
        id: json['id'],
        phuongID: json['phuongID'],
        tenPhuong: json['tenPhuong'],
        maPhuongXa: json['maPhuongXa'],
        maPhuong: json['maPhuong']);
  }
}
