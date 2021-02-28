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

  final String Name;
  final String Email;
  final String Phone;
  final String Address;
  final String Password;

  DangKyUserParam({this.Name='', this.Email='', this.Phone='', this.Address='', this.Password=''});

}
