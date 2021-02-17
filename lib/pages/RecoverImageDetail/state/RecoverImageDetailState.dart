import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:image_recovery/pages/RecoverImageResult/model/ImageResult.dart';
import 'package:image_recovery/pages/home/model/ModelImage.dart';

abstract class RecoverImageDetailState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class RecoverImageDetailStateInitial extends RecoverImageDetailState {
  RecoverImageDetailStateInitial();
  RecoverImageDetailStateInitial copy(data, response) => RecoverImageDetailStateInitial();
  @override
  // TODO: implement props

  List<Object> get props => [];
}

class RecoverImageDetailStateFailure extends RecoverImageDetailState {
  RecoverImageDetailStateFailure();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class RecoverImageDetailStateStart extends RecoverImageDetailState {
  List<ModelImage> images;
  bool isRecover;
  bool isCancelRecover;
  bool isFalse;
  RecoverImageDetailStateStart(this.images, this.isRecover, this.isCancelRecover, this.isFalse);
  RecoverImageDetailStateStart copy(images, isRecover,isCancelRecover)
  => RecoverImageDetailStateStart(images?? this.images,
      this.isRecover, this.isCancelRecover, this.isFalse);
  @override
  // TODO: implement props
  List<Object> get props => [this.images, this.isRecover, this.isCancelRecover, this.isFalse];
}

class RecoverImageDetailStateRecoverySucces extends RecoverImageDetailState {
  List<ImageResult> images;
  RecoverImageDetailStateRecoverySucces(this.images);
  @override
  // TODO: implement props
  List<Object> get props => [this.images];
}
