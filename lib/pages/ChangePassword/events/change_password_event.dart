import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class ChangePasswordEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ChangePasswordEventStart extends ChangePasswordEvent{
  bool isChanging;
  bool isFailure;
  String error;
  String oldPassword;
  String newPassword;
  BuildContext context;
  ChangePasswordEventStart(this.isChanging,this.isFailure, this.oldPassword, this.newPassword, this.context, this.error);
  @override
  // TODO: implement props
  List<Object> get props => [this.isChanging,this.isFailure, this.oldPassword, this.newPassword, this.context, this.error];
}

