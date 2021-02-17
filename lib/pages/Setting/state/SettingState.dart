import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:image_recovery/pages/Filter/model/matrix.dart';
import 'package:image_recovery/pages/SoThuTu/Model/model/PostSTTResponse.dart';

abstract class SettingState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class SettingStateInitial extends SettingState {
  SettingStateInitial();
  SettingStateInitial copy() => SettingStateInitial();
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class SettingStateStart extends SettingState {
  SettingStateStart();
  SettingStateStart copy() => SettingStateStart();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SettingStateFailure extends SettingState {
  SettingStateFailure();
  @override
  // TODO: implement props
  List<Object> get props => [];
}


