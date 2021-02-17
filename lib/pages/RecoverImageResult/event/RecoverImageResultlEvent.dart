import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:image_recovery/pages/RecoverImageResult/model/ImageResult.dart';
import 'package:image_recovery/pages/home/model/ModelImage.dart';

abstract class RecoverImageResultEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class RecoverImageResultEventStart extends RecoverImageResultEvent{
  List<ImageResult> image;
  RecoverImageResultEventStart(this.image);
}