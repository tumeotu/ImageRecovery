import 'dart:typed_data';
import 'package:equatable/equatable.dart';

abstract class DetailImageEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class DetailImageEventStart extends DetailImageEvent{
  Uint8List image;
  DetailImageEventStart(this.image);
}

