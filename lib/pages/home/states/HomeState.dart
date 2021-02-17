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
  HomeStateStart(this.page);
  HomeStateStart copy(page) => HomeStateStart(this.page);
  @override
  // TODO: implement props
  List<Object> get props => [this.page];
}
