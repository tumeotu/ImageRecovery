import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:image_recovery/pages/Filter/model/matrix.dart';
import 'package:image_recovery/pages/SoThuTu/Model/model/PostSTTResponse.dart';

abstract class DetailImageState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class DetailImageMainStateInitial extends DetailImageState {
  DetailImageMainStateInitial();
  DetailImageMainStateInitial copy() => DetailImageMainStateInitial();
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class DetailImageMainStateStart extends DetailImageState {
  Uint8List image;
  DetailImageMainStateStart(this.image);
  DetailImageMainStateStart copy(image) => DetailImageMainStateStart(this.image);
  @override
  // TODO: implement props
  List<Object> get props => [this.image];
}

class DetailImageMainStateFailure extends DetailImageState {
  DetailImageMainStateFailure();
  @override
  // TODO: implement props
  List<Object> get props => [];
}


