import 'dart:typed_data';
import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class HomeEventStart extends HomeEvent{
  int page;
  HomeEventStart(this.page);
}
