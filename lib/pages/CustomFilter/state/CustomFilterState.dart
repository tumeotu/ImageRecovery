import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_recovery/data/models/dashboard_models.dart';
import 'package:image_recovery/modules/tintuc/models/tintuc_models.dart';
import 'package:image_recovery/pages/Filter/model/matrix.dart';
import 'package:image_recovery/pages/SoThuTu/Model/model/PostSTTResponse.dart';
import 'package:image_recovery/pages/SoThuTu/Model/model/sothutu.dart';

abstract class CustomFilterState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class CustomFilterMainStateInitial extends CustomFilterState {
  CustomFilterMainStateInitial();
  CustomFilterMainStateInitial copy(data, response) => CustomFilterMainStateInitial();
  @override
  // TODO: implement props

  List<Object> get props => [];
}

class CustomFilterMainStateFailure extends CustomFilterState {
  CustomFilterMainStateFailure();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CustomFilterStartSuccess extends CustomFilterState {
  Uint8List image;
  double sat;
  double bright;
  double con;
  CustomFilterStartSuccess(this.image, this.sat, this.bright, this.con);
  CustomFilterStartSuccess copy(data, response) => CustomFilterStartSuccess(this.image, this.sat, this.bright, this.con);
  @override
  // TODO: implement props
  List<Object> get props => [this.image, this.sat, this.bright, this.con];
}
