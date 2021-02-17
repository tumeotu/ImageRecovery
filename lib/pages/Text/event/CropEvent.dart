import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';


abstract class TextEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class TextEventStart extends TextEvent{
  Color color;
  double size;
  TextEventStart(this.color, this.size);

}
