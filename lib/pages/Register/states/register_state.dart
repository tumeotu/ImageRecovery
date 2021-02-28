import 'dart:typed_data';
import 'package:equatable/equatable.dart';
import 'package:image_recovery/pages/Filter/model/matrix.dart';

abstract class RegisterState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class RegisterStateInitial extends RegisterState {
  bool isRegister;
  bool isFailure;
  String Name;
  String Phone;
  String Email;
  String Address;
  String Password;
  RegisterStateInitial(this.isRegister,this.isFailure, this.Name, this.Phone,
      this.Email, this.Address, this.Password);
  @override
  // TODO: implement props
  List<Object> get props => [this.isRegister,this.isFailure, this.Name, this.Phone,
    this.Email, this.Address, this.Password];
}

class RegisterStateFailure extends RegisterState {
  RegisterStateFailure();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class RegisterStateStart extends RegisterState {
  bool isLogin;
  RegisterStateStart(this.isLogin);
  @override
  // TODO: implement props
  List<Object> get props => [this.isLogin];
}

