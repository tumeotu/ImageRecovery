

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_recovery/data/models/user_models.dart';

class EditAccountEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class EditAccountEventStart extends EditAccountEvent{
  bool isRegister;
  bool isFailure;
  String Name;
  String Phone;
  String Email;
  String Address;
  String Password;
  EditAccountEventStart(this.isRegister,this.isFailure, this.Name, this.Phone,
      this.Email, this.Address, this.Password);
  @override
  // TODO: implement props
  List<Object> get props => [this.isRegister,this.isFailure, this.Name, this.Phone,
    this.Email, this.Address, this.Password];
}

class EditAccountEventEdit extends EditAccountEvent{
  bool isFailure;
  String Name;
  String Phone;
  String Email;
  String Address;
  BuildContext context;
  EditAccountEventEdit(this.isFailure, this.Name, this.Phone,
      this.Email, this.Address, this.context);
  @override
  // TODO: implement props
  List<Object> get props => [this.isFailure, this.Name, this.Phone,
    this.Email, this.Address, this.context];
}

