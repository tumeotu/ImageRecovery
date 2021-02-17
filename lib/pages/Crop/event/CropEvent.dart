import 'dart:typed_data';
import 'package:equatable/equatable.dart';


abstract class CropEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CropEventStart extends CropEvent{
  double cropAspectRatio;
  bool flip;
  bool rotate;
  Uint8List image;
  CropEventStart(this.cropAspectRatio, this.flip, this.rotate, this.image);

}
