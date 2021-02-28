import 'dart:typed_data';

import 'package:image_recovery/data/models/user_models.dart';

abstract class LoginDataSource{
  Future<UserInfoModel> login(String userName, String password);
  Future<UserInfoModel> register(DangKyUserParam param);
  Future<UserInfoModel> edit_account(DangKyUserParam param, String Token);
  Future<UserInfoModel> login_facebook(String accessToken, String userID);
  Future<UserInfoModel> login_google(String accessToken);
  Future<UserInfoModel> change_avatar(String Token, Uint8List image);
  Future<UserInfoModel> verify_email(String email);
  Future<UserInfoModel> change_password(String Token,String oldPassword, String newPassword);
}

class UserInfoModel{
  int iD;
  String name;
  String dOB;
  int gender;
  String email;
  String address;
  String numberphone;
  String picture;
  String token;

  UserInfoModel(
  {this.iD,
  this.name,
  this.dOB,
  this.gender,
  this.email,
  this.address,
  this.numberphone,
  this.picture,
  this.token});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
  iD = json['ID'];
  name = json['Name'];
  dOB = json['DOB'];
  gender = json['Gender'];
  email = json['Email'];
  address = json['Address'];
  numberphone = json['Numberphone'];
  picture = json['Picture'];
  token = json['token'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['ID'] = this.iD;
  data['Name'] = this.name;
  data['DOB'] = this.dOB;
  data['Gender'] = this.gender;
  data['Email'] = this.email;
  data['Address'] = this.address;
  data['Numberphone'] = this.numberphone;
  data['Picture'] = this.picture;
  data['token'] = this.token;
  return data;
  }
}