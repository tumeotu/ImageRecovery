import 'dart:typed_data';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class HomeStateInitial extends HomeState {
  HomeStateInitial();
  HomeStateInitial copy() => HomeStateInitial();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class HomeStateFailure extends HomeState {
  HomeStateFailure();
  @override
  // TODO: implement props
  List<Object> get props => [];
}


class HomeStateStart extends HomeState {
  int page;
  Uint8List image;
  HomeStateStart(this.page, this.image);
  HomeStateStart copy(page, image) => HomeStateStart(this.page, this.image);
  @override
  // TODO: implement props
  List<Object> get props => [this.page, this.image];
}
