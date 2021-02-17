class UserCitizenLoginResult {
  final String userName;
  final double donViDoVeID;
  final String hoTen;
  final String soDT;
  final String email;
  final String thongBao;

  UserCitizenLoginResult(
      {this.userName,
      this.donViDoVeID,
      this.hoTen,
      this.soDT,
      this.email,
      this.thongBao});

  factory UserCitizenLoginResult.fromJson(Map<String, dynamic> json) {
    final volumeInfo = json['volumeInfo'];
    return UserCitizenLoginResult(
      userName: json['userName'],
      donViDoVeID: json['donViDoVeID'],
      hoTen: json['hoTen'],
      soDT: json['soDT'],
      email: json['email'],
      thongBao: json['thongBao'],
    );
  }
}

class DangKyUserParam {
  final String UserName;
  final String HoTen;
  final String Email;
  final String SoDT;
  final String SoCMND;

  DangKyUserParam({this.UserName='', this.HoTen='', this.Email='', this.SoDT='', this.SoCMND=''});
  Map<String, String> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['UserName'] = this.UserName;
    data['HoTen'] = this.HoTen;
    data['Email'] = this.Email;
    data['SoDT'] = this.SoDT;
    data['SoCMND'] = this.SoCMND;
    return data;
  }
}
