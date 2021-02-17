class DuongDanhMucModel {
  final int id;
  final int duongID;
  final String tenDuong;

  const DuongDanhMucModel({this.id, this.duongID, this.tenDuong});

  factory DuongDanhMucModel.fromJson(Map<String, dynamic> json) {
    return DuongDanhMucModel(
        id: json['id'], duongID: json['duongID'], tenDuong: json['tenDuong']);
  }
}
