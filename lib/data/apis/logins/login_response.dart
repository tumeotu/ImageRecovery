import 'package:get_it/get_it.dart';
import '../../../data/apis/logins/login_datasource.dart';
import '../../../data/models/user_models.dart';
import '../../../utils/networks/network_datasource.dart';

import '../../../constants.dart';

class LoginResponse extends LoginDataSource {
  @override
  Future<UserCitizenLoginResult> loginUserCitizen(String userName) async {
    try {
      final url = BASE_URL + '/api/LoginUser_NguoiDan';
      var param = new Map<String, String>();
      param['UserName'] = userName;
      final data = await GetIt.instance
          .get<NetworkDataSource>()
          .post(Uri.parse(url), body: param);
      return UserCitizenLoginResult.fromJson(data);
    } catch (error) {
      print(error);
      return null;
    }
  }

  @override
  Future<bool> checkCodeByUserLogin(String userName,String code) async{
    try {
      final url = BASE_URL + '/api/CheckCodeByUser_Login';
      var param = new Map<String, String>();
      param['UserName'] = userName;
      param['Code'] = code;
      final data = await GetIt.instance
          .get<NetworkDataSource>()
          .post(Uri.parse(url), body: param);
      return data as bool;
    } catch (error) {
      print(error);
      return null;
    }
  }

  @override
  Future<bool> CheckCodeRegisterUserCitizen(String userName, String code)async {
    try {
      final url = BASE_URL + '/api/CheckCodeByUser_DangKy';
      var param = new Map<String, String>();
      param['UserName'] = userName;
      param['Code'] = code;
      final data = await GetIt.instance
          .get<NetworkDataSource>()
          .post(Uri.parse(url), body: param);
      return data as bool;
    } catch (error) {
      print(error);
      return null;
    }
  }


  @override
  Future<bool> RegisterUserCitizen(DangKyUserParam param)async {
    try {
      final url = BASE_URL + '/api/DangKyUser_NguoiDan';
      var paramSend = param.toJson();
      final data = await GetIt.instance
          .get<NetworkDataSource>()
          .post(Uri.parse(url), body: paramSend);
      return data as bool;
    } catch (error) {
      print('RegisterUserCitizen $error');
      return null;
    }
  }
}
