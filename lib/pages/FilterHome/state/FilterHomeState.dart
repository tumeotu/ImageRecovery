import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_recovery/data/models/dashboard_models.dart';
import 'package:image_recovery/modules/tintuc/models/tintuc_models.dart';
import 'package:image_recovery/pages/Filter/model/matrix.dart';
import 'package:image_recovery/pages/SoThuTu/Model/model/PostSTTResponse.dart';
import 'package:image_recovery/pages/SoThuTu/Model/model/sothutu.dart';

abstract class FilterHomeState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class FilterHomeStateInitial extends FilterHomeState {
  FilterHomeStateInitial();
  FilterHomeStateInitial copy(data, response) => FilterHomeStateInitial();
  @override
  // TODO: implement props

  List<Object> get props => [];
}

class FilterHomeStateFailure extends FilterHomeState {
  FilterHomeStateFailure();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FilterHomeStateStart extends FilterHomeState {
  FilterHomeStateStart();
  FilterHomeStateStart copy() => FilterHomeStateStart();
  @override
  // TODO: implement props
  List<Object> get props => [];
}
