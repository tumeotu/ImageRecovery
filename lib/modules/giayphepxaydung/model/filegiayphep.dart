class FileGiayPheps {
  String fileUrl;
  String tenFile;
  String loaiFile;

  FileGiayPheps({this.fileUrl, this.tenFile, this.loaiFile});

  FileGiayPheps.fromJson(Map<String, dynamic> json) {
    fileUrl = json['fileUrl'];
    tenFile = json['tenFile'];
    loaiFile = json['loaiFile'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fileUrl'] = this.fileUrl;
    data['tenFile'] = this.tenFile;
    data['loaiFile'] = this.loaiFile;
    return data;
  }
}