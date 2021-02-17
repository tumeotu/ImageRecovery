import 'dart:typed_data';
import 'package:equatable/equatable.dart';

abstract class CropState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class CropMainStateInitial extends CropState {
  CropMainStateInitial();
  CropMainStateInitial copy(data, response) => CropMainStateInitial();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CropMainStateFailure extends CropState {
  CropMainStateFailure();
  @override
  // TODO: implement props
  List<Object> get props => [];
}


class CropStateStart extends CropState {
  double cropAspectRatio;
  bool flip;
  bool rotate;
  Uint8List image;
  CropStateStart(this.image, this.cropAspectRatio, this.flip, this.rotate);
  CropStateStart copy(data, response) => CropStateStart(this.image, this.cropAspectRatio,this.flip,this.rotate);
  @override
  // TODO: implement props
  List<Object> get props => [this.image, this.cropAspectRatio, this.flip, this.rotate];
}
