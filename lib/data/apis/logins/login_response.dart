import 'package:get_it/get_it.dart';
import '../../../data/apis/logins/login_datasource.dart';
import '../../../data/models/user_models.dart';
import '../../../utils/networks/network_datasource.dart';
import '../../../constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

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
  Future<UserInfoModel> register(DangKyUserParam param) {
    // TODO: implement register
    throw UnimplementedError();
  }

}
