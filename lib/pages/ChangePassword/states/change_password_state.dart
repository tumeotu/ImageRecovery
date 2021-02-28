import 'dart:typed_data';
import 'package:equatable/equatable.dart';
import 'package:image_recovery/pages/Filter/model/matrix.dart';

abstract class ChangePasswordState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class ChangePasswordStateInitial extends ChangePasswordState {
  ChangePasswordStateInitial();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ChangePasswordStateFailure extends ChangePasswordState {
  ChangePasswordStateFailure();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ChangePasswordStateStart extends ChangePasswordState {
  bool isChanging;
  bool isFailure;
  String error;
  String oldPassword;
  String newPassword;
  ChangePasswordStateStart(this.isChanging,this.isFailure, this.oldPassword, this.newPassword, this.error);
  @override
  // TODO: implement props
  List<Object> get props => [this.isChanging,this.isFailure, this.oldPassword, this.newPassword, this.error];
}

