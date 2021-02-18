import 'dart:typed_data';
import 'package:equatable/equatable.dart';
import 'package:image_recovery/pages/Filter/model/matrix.dart';

abstract class LoginState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class LoginStateInitial extends LoginState {
  bool isLogin;
  bool isFailure;
  String userName;
  String password;
  LoginStateInitial(this.isLogin,this.isFailure, this.userName, this.password);
  LoginStateInitial copy(isLogin,isFailure) => LoginStateInitial(this.isLogin,this.isFailure, this.userName, this.password);
  @override
  // TODO: implement props

  List<Object> get props => [this.isLogin,this.isFailure, this.userName, this.password];
}

class LoginStateFailure extends LoginState {
  LoginStateFailure();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoginStateStart extends LoginState {
  bool isLogin;
  LoginStateStart(this.isLogin);
  @override
  // TODO: implement props
  List<Object> get props => [this.isLogin];
}

class LoginStateSuccess extends LoginState {
  LoginStateSuccess();
  @override
  LoginStateSuccess copy() => LoginStateSuccess();
  @override
  // TODO: implement props

  List<Object> get props => [];
}
