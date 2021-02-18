

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_recovery/data/models/user_models.dart';

class LoginEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoginEventStart extends LoginEvent{
  bool isLogin;
  bool isFailure;
  String userName;
  String password;
  LoginEventStart(this.isLogin,this.isFailure, this.userName, this.password);
  @override
  // TODO: implement props
  List<Object> get props => [this.isLogin, this.isFailure, this.userName, this.password];
}

class LoginEventSignInUser extends LoginEvent{
  final String userName;
  final String password;
  final bool isSaveAccount;
  final BuildContext context;
  LoginEventSignInUser(this.userName, this.password, this.isSaveAccount, this.context);
}
class LoginEventSinginFacebook extends LoginEvent{
  final String accessToken;
  final String userID;
  final bool isSuccess;
  final BuildContext context;
  LoginEventSinginFacebook(this.accessToken,this.userID, this.isSuccess, this.context);
}

class LoginEventSinginGoogle extends LoginEvent{
  final String accessToken;
  final bool isSuccess;
  final BuildContext context;
  LoginEventSinginGoogle(this.accessToken, this.isSuccess, this.context);
}
