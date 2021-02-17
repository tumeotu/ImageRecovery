import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:image_recovery/pages/RecoverImageResult/model/ImageResult.dart';
import 'package:image_recovery/pages/home/model/ModelImage.dart';

abstract class RecoverImageResultState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class RecoverImageResultStateInitial extends RecoverImageResultState {
  RecoverImageResultStateInitial();
  RecoverImageResultStateInitial copy(data, response) => RecoverImageResultStateInitial();
  @override
  // TODO: implement props

  List<Object> get props => [];
}

class RecoverImageResultStateFailure extends RecoverImageResultState {
  RecoverImageResultStateFailure();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class RecoverImageResultStateStart extends RecoverImageResultState {
  List<ImageResult> images;
  RecoverImageResultStateStart(this.images);
  RecoverImageResultStateStart copy(images) => RecoverImageResultStateStart(images?? this.images);
  @override
  // TODO: implement props
  List<Object> get props => [this.images];
}
