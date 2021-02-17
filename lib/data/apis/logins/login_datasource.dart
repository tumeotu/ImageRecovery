import 'package:image_recovery/data/models/user_models.dart';

abstract class LoginDataSource{
  Future<UserCitizenLoginResult> loginUserCitizen(String userName);
  Future<bool> checkCodeByUserLogin(String userName,String code);
  Future<bool> CheckCodeRegisterUserCitizen(String userName,String code);
  Future<bool> RegisterUserCitizen(DangKyUserParam param);
}