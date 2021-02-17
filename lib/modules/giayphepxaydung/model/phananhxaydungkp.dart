class PhanAnhXayDungKPs {
  double gpSLat;
  double gpSLng;
  int id;

  PhanAnhXayDungKPs({this.gpSLat, this.gpSLng, this.id});

  PhanAnhXayDungKPs.fromJson(Map<String, dynamic> json) {
    gpSLat = json['gpS_lat'];
    gpSLng = json['gpS_lng'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gpS_lat'] = this.gpSLat;
    data['gpS_lng'] = this.gpSLng;
    data['id'] = this.id;
    return data;
  }
}