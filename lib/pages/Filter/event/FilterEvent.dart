import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_recovery/pages/Filter/model/matrix.dart';

abstract class FilterEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FilterEventStart extends FilterEvent{
  Uint8List image;
  Filter filter;
  FilterEventStart(this.image, this.filter);
}