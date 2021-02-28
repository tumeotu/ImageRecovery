import 'dart:typed_data';
import 'package:equatable/equatable.dart';
import 'package:image_recovery/pages/Filter/model/matrix.dart';

abstract class AccountState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class AccountStateInitial extends AccountState {
  AccountStateInitial();
  AccountStateInitial copy() => AccountStateInitial();
  @override
  // TODO: implement props

  List<Object> get props => [];
}

class AccountStateFailure extends AccountState {
  AccountStateFailure();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AccountStateStart extends AccountState {
  bool isChanging;
  bool isFailure;
  Map userInfor;
  AccountStateStart(this.userInfor, this.isChanging, this.isFailure);
  @override
  // TODO: implement props
  List<Object> get props => [this.userInfor, this.isChanging, this.isFailure];
}

