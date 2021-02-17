import 'dart:typed_data';
import 'package:equatable/equatable.dart';
import 'package:image_recovery/pages/Filter/model/matrix.dart';

abstract class PhotoViewState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class PhotoViewStateInitial extends PhotoViewState {
  PhotoViewStateInitial();
  PhotoViewStateInitial copy(data, response) => PhotoViewStateInitial();
  @override
  // TODO: implement props

  List<Object> get props => [];
}

class PhotoViewStateFailure extends PhotoViewState {
  PhotoViewStateFailure();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class PhotoViewStateStart extends PhotoViewState {
  int page;
  Uint8List oldImage;
  Uint8List newImage;
  bool isDetect;
  bool isFalse;
  PhotoViewStateStart(this.page, this.oldImage, this.newImage, this.isDetect, this.isFalse);
  @override
  // TODO: implement props
  List<Object> get props => [this.page, this.oldImage, this.newImage, this.isDetect, this.isFalse];
}

class PhotoViewStatePost extends PhotoViewState {
  Uint8List oldImage;
  Uint8List newImage;
  PhotoViewStatePost(this.oldImage, this.newImage);
  @override
  PhotoViewStatePost copy(oldImage, newImage) => PhotoViewStatePost(oldImage??this.oldImage, newImage?? this.newImage);
  @override
  // TODO: implement props

  List<Object> get props => [this.oldImage, this.newImage];
}
