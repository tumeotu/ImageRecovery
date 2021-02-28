

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_recovery/data/models/user_models.dart';

class RegisterEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class RegisterEventStart extends RegisterEvent{
  bool isRegister;
  bool isFailure;
  String Name;
  String Phone;
  String Email;
  String Address;
  String Password;
  RegisterEventStart(this.isRegister,this.isFailure, this.Name, this.Phone,
      this.Email, this.Address, this.Password);
  @override
  // TODO: implement props
  List<Object> get props => [this.isRegister,this.isFailure, this.Name, this.Phone,
    this.Email, this.Address, this.Password];
}

class RegisterEventRegister extends RegisterEvent{
  bool isFailure;
  String Name;
  String Phone;
  String Email;
  String Address;
  String Password;
  BuildContext context;
  RegisterEventRegister(this.isFailure, this.Name, this.Phone,
      this.Email, this.Address, this.Password, this.context);
  @override
  // TODO: implement props
  List<Object> get props => [this.isFailure, this.Name, this.Phone,
    this.Email, this.Address, this.Password, this.context];
}

