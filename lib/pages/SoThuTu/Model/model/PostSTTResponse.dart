class STTResponse {
  bool isSuccess;
  String thongBao;

  STTResponse({this.isSuccess, this.thongBao});

  STTResponse.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    thongBao = json['thongBao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isSuccess'] = this.isSuccess;
    data['thongBao'] = this.thongBao;
    return data;
  }
}
