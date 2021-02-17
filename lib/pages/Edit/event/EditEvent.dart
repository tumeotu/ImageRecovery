import 'dart:typed_data';
import 'package:equatable/equatable.dart';

abstract class EditEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class EditEventStart extends EditEvent{
  Uint8List image;
  EditEventStart(this.image);
}

