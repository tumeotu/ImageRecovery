import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class TextState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class TextMainStateInitial extends TextState {
  TextMainStateInitial();
  TextMainStateInitial copy(data, response) => TextMainStateInitial();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class TextMainStateFailure extends TextState {
  TextMainStateFailure();
  @override
  // TODO: implement props
  List<Object> get props => [];
}


class TextStateStart extends TextState {
  Color color;
  double size;
  TextStateStart(this.color, this.size);
  TextStateStart copy(data, response) => TextStateStart(this.color, this.size);
  @override
  // TODO: implement props
  List<Object> get props => [this.color, this.size];
}
