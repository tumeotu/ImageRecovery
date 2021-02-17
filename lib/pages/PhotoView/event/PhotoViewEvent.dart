import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_recovery/pages/Filter/model/matrix.dart';

abstract class PhotoViewEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class PhotoViewEventStart extends PhotoViewEvent{
  int page;
  Uint8List oldImage;
  Uint8List newImage;
  PhotoViewEventStart(this.page, this.oldImage, this.newImage);
}

class PhotoViewEventPost extends PhotoViewEvent{
  Uint8List oldImage;
  int page;
  Uint8List newImage;
  BuildContext context;
  PhotoViewEventPost(this.page,this.oldImage, this.newImage, this.context);
}