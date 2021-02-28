import 'dart:typed_data';

import 'package:get_it/get_it.dart';
import '../../../data/apis/logins/login_datasource.dart';
import '../../../data/models/user_models.dart';
import '../../../utils/networks/network_datasource.dart';
import '../../../constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';

class LoginResponse extends LoginDataSource {
  @override
  Future<UserInfoModel> login(String userName, String password) async {
    try {
      final url = BASE_URL + '/api/v1/user/login';
      var body = json.encode({
        "UserName": userName,
        "Password": password,
      });
      Map<String,String> headers = {
        'Content-type' : 'application/json',
        'Accept': 'application/json',
      };
      final response =
      await http.post(url, body: body, headers: headers);
      final responseJson = json.decode(response.body);
      return UserInfoModel.fromJson(responseJson);
    } catch (error) {
      print(error);
      return null;
    }
  }

  @override
  Future<UserInfoModel> login_facebook(String accessToken, String userID) async {
    try {
      final url = BASE_URL + '/api/v1/user/login_facebook';
      var body = json.encode({
        "AccessToken": accessToken,
        "UserID": userID,
      });
      Map<String,String> headers = {
        'Content-type' : 'application/json',
        'Accept': 'application/json',
      };
      final response =
      await http.post(url, body: body, headers: headers);
      final responseJson = json.decode(response.body);
      return UserInfoModel.fromJson(responseJson);
    } catch (error) {
      print(error);
      return null;
    }
  }

  @override
  Future<UserInfoModel> login_google(String accessToken) async {
    try {
      final url = BASE_URL + '/api/v1/user/login_google';
      var body = json.encode({
        "AccessToken": accessToken,
      });
      Map<String,String> headers = {
        'Content-type' : 'application/json',
        'Accept': 'application/json',
      };
      final response =
      await http.post(url, body: body, headers: headers);
      final responseJson = json.decode(response.body);
      return UserInfoModel.fromJson(responseJson);
    } catch (error) {
      print(error);
      return null;
    }
  }

  @override
  Future<UserInfoModel> register(DangKyUserParam param) async {
    try {
      final url = BASE_URL + '/api/v1/user/register';
      final DateTime now = DateTime.now();
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      final String formatted = formatter.format(now);
      var body = json.encode({
        "Name": param.Name,
        "Email": param.Email,
        "Numberphone": param.Phone,
        "Address": param.Address,
        "DOB": formatted,
        "Gender": '1',
        "Password": param.Password,
        "Picture": '',
      });
      Map<String,String> headers = {
        'Content-type' : 'application/json',
        'Accept': 'application/json',
      };
      final response =
          await http.post(url, body: body, headers: headers);
      final responseJson = json.decode(response.body);
      return UserInfoModel.fromJson(responseJson);
    } catch (error) {
      print(error);
      return null;
    }
  }

  @override
  Future<UserInfoModel> edit_account(DangKyUserParam param, String Token) async {
    try {
      final url = BASE_URL + '/api/v1/user/info/edit';
      final DateTime now = DateTime.now();
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      final String formatted = formatter.format(now);
      var body = json.encode({
        "Name": param.Name,
        "Email": param.Email,
        "Numberphone": param.Phone,
        "Address": param.Address,
        "DOB": formatted,
        "Gender": 1,
      });
      Map<String,String> headers = {
        'Content-type' : 'application/json',
        'Accept': 'application/json',
        'Authorization':Token
      };
      final response =
          await http.post(url, body: body, headers: headers);
      final responseJson = json.decode(response.body);
      return UserInfoModel.fromJson(responseJson);
    } catch (error) {
      print(error);
      return null;
    }
  }

  @override
  Future<UserInfoModel> change_avatar(String Token, Uint8List image) async {
    try {
      final url = BASE_URL + '/api/v1/user/avatar/edit';
      var request = http.MultipartRequest('POST', Uri.parse(url));
      var param = {
        "Authorization":Token
      };
      request.headers.addAll(param);
      request.files.add(
          http.MultipartFile.fromBytes(
              'image',
              image,
              filename: 'image.jpg'
          )
      );
      var res = await request.send();
      var responseByteArray = await res.stream.toBytes();
      var datas =json.decode(utf8.decode(responseByteArray));
      return UserInfoModel.fromJson(datas);
    } catch (Exception) {
      print("Recover Excepton"+Exception.toString());
      return null;
    }
  }


  @override
  Future<UserInfoModel> verify_email(String email) async {
    try {
      final url = BASE_URL + '/api/v1/user/account/verify-email';
      var body = json.encode({
        "UserName": email,
      });
      Map<String,String> headers = {
        'Content-type' : 'application/json',
        'Accept': 'application/json',
      };
      final response =
      await http.post(url, body: body, headers: headers);
      final responseJson = json.decode(response.body);
      return UserInfoModel.fromJson(responseJson);
    } catch (error) {
      print(error);
      return null;
    }
  }

  @override
  Future<UserInfoModel> change_password(String Token,String oldPassword, String newPassword) async {
    try {
      final url = BASE_URL + '/api/v1/user/account/edit_password';
      var body = json.encode({
        "OldPassword": oldPassword,
        "NewPassword": newPassword,
      });
      Map<String,String> headers = {
        'Content-type' : 'application/json',
        'Accept': 'application/json',
        'Authorization':Token
      };
      final response =
      await http.post(url, body: body, headers: headers);
      final responseJson = json.decode(response.body);
      return UserInfoModel.fromJson(responseJson);
    } catch (error) {
      print(error);
      return null;
    }
  }
}
