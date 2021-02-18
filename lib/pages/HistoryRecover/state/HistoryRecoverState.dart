import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:image_recovery/data/apis/history_recover/HistoryDataSource.dart';
import 'package:image_recovery/pages/RecoverImageResult/model/ImageResult.dart';
import 'package:image_recovery/pages/home/model/ModelImage.dart';

abstract class HistoryRecoverState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class HistoryRecoverStateInitial extends HistoryRecoverState {
  HistoryRecoverStateInitial();
  HistoryRecoverStateInitial copy() => HistoryRecoverStateInitial();
  @override
  // TODO: implement props

  List<Object> get props => [];
}

class HistoryRecoverStateFailure extends HistoryRecoverState {
  HistoryRecoverStateFailure();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class HistoryRecoverStateMustLogin extends HistoryRecoverState {
  HistoryRecoverStateMustLogin();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class HistoryRecoverStateMustConnectInterNet extends HistoryRecoverState {
  HistoryRecoverStateMustConnectInterNet();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class HistoryRecoverStateStart extends HistoryRecoverState {
  List<HistoryDatasourceModel> images;
  bool isGetDetail;
  bool isFailure;
  HistoryRecoverStateStart(this.images, this.isGetDetail, this.isFailure);
  HistoryRecoverStateStart copy(images, isGetDetail,isFailure)
  => HistoryRecoverStateStart(images?? this.images, this.isGetDetail, this.isFailure);
  @override
  // TODO: implement props
  List<Object> get props => [this.images, this.isGetDetail, this.isFailure];
}

