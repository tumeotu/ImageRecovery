import 'dart:io';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_recovery/pages/RecoverImageResult/model/ImageResult.dart';
import 'package:image_recovery/pages/home/model/ModelImage.dart';

abstract class RecoverImageDetailEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class RecoverImageDetailEventStart extends RecoverImageDetailEvent{
  List<ModelImage> image;
  RecoverImageDetailEventStart(this.image);
}
class RecoverImageDetailEventPost extends RecoverImageDetailEvent{
  List<ImageResult> image;
  BuildContext context;
  bool isRecover;
  RecoverImageDetailEventPost(this.image, this.context, this.isRecover);
}