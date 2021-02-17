import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_recovery/pages/Filter/model/matrix.dart';

abstract class CustomFilterEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CustomFilterEventStart extends CustomFilterEvent{
  Uint8List image;
  double sat;
  double bright;
  double con;
  CustomFilterEventStart(this.image, this.sat, this.bright, this.con);
}