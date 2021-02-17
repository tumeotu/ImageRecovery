import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_recovery/pages/DetectResult/Model/ImageResultDetect.dart';
import 'package:image_recovery/pages/Filter/model/matrix.dart';

abstract class DetectViewEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class DetectViewEventStart extends DetectViewEvent{
  List<ImageResultDetect> images;
  DetectViewEventStart(this.images);
}