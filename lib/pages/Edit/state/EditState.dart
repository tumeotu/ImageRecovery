import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:image_recovery/pages/Filter/model/matrix.dart';
import 'package:image_recovery/pages/SoThuTu/Model/model/PostSTTResponse.dart';

abstract class EditState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class EditMainStateInitial extends EditState {
  EditMainStateInitial();
  EditMainStateInitial copy() => EditMainStateInitial();
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class EditMainStateStart extends EditState {
  Uint8List image;
  EditMainStateStart(this.image);
  EditMainStateStart copy(image) => EditMainStateStart(this.image);
  @override
  // TODO: implement props
  List<Object> get props => [this.image];
}

class EditMainStateFailure extends EditState {
  EditMainStateFailure();
  @override
  // TODO: implement props
  List<Object> get props => [];
}


