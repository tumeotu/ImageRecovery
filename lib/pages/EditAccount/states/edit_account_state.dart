import 'dart:typed_data';
import 'package:equatable/equatable.dart';
import 'package:image_recovery/pages/Filter/model/matrix.dart';

abstract class EditAccountState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class EditAccountStateInitial extends EditAccountState {
  bool isRegister;
  bool isFailure;
  String Name;
  String Phone;
  String Email;
  String Address;
  EditAccountStateInitial(this.isRegister,this.isFailure, this.Name, this.Phone,
      this.Email, this.Address);
  @override
  // TODO: implement props
  List<Object> get props => [this.isRegister,this.isFailure, this.Name, this.Phone,
    this.Email, this.Address];
}

class EditAccountStateFailure extends EditAccountState {
  EditAccountStateFailure();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class EditAccountStateStart extends EditAccountState {
  bool isLogin;
  EditAccountStateStart(this.isLogin);
  @override
  // TODO: implement props
  List<Object> get props => [this.isLogin];
}

