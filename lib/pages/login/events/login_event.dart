

import 'package:equatable/equatable.dart';
import 'package:image_recovery/data/models/user_models.dart';

class LoginEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class LoginEventSignInUser extends LoginEvent{
  final String userName;
  LoginEventSignInUser(this.userName);
}
class LoginEventCheckCodeUser extends LoginEvent{
  final String userName;
  final String code;
  LoginEventCheckCodeUser(this.userName,this.code);
}
class LoginEventCheckCodeRegister extends LoginEvent{
  final String userName;
  final String code;
  LoginEventCheckCodeRegister(this.userName,this.code);
}
class LoginEvenRegisterUserCitizen extends LoginEvent{
  final DangKyUserParam modelParam;
  LoginEvenRegisterUserCitizen(this.modelParam);
}