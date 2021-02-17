import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_recovery/data/models/dashboard_models.dart';
import 'package:image_recovery/modules/tintuc/models/tintuc_models.dart';
import 'package:image_recovery/pages/Filter/model/matrix.dart';
import 'package:image_recovery/pages/SoThuTu/Model/model/PostSTTResponse.dart';
import 'package:image_recovery/pages/SoThuTu/Model/model/sothutu.dart';

abstract class FilterState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class FilterMainStateInitial extends FilterState {
  FilterMainStateInitial();
  FilterMainStateInitial copy(data, response) => FilterMainStateInitial();
  @override
  // TODO: implement props

  List<Object> get props => [];
}

class FilterMainStateFailure extends FilterState {
  FilterMainStateFailure();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FilterFilterState extends FilterState {
  Uint8List image;
  Filter filter;
  FilterFilterState(this.image, this.filter);
  FilterFilterState copy(data, response) => FilterFilterState(this.image, this.filter);
  @override
  // TODO: implement props
  List<Object> get props => [this.image, this.filter];
}
class FilterStartSuccess extends FilterState {
  Uint8List image;
  Filter filter;
  FilterStartSuccess(this.image, this.filter);
  FilterStartSuccess copy(data, response) => FilterStartSuccess(this.image, this.filter);
  @override
  // TODO: implement props
  List<Object> get props => [this.image, this.filter];
}
