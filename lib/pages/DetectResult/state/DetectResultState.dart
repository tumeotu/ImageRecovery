import 'dart:typed_data';
import 'package:equatable/equatable.dart';
import 'package:image_recovery/pages/DetectResult/Model/ImageResultDetect.dart';
import 'package:image_recovery/pages/Filter/model/matrix.dart';

abstract class DetectViewState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class DetectViewStateInitial extends DetectViewState {
  DetectViewStateInitial();
  DetectViewStateInitial copy(data, response) => DetectViewStateInitial();
  @override
  // TODO: implement props

  List<Object> get props => [];
}

class DetectViewStateFailure extends DetectViewState {
  DetectViewStateFailure();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class DetectViewStateStart extends DetectViewState {
  List<ImageResultDetect> image;
  DetectViewStateStart(this.image);
  @override
  // TODO: implement props
  List<Object> get props => [this.image];
}
