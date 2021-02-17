import 'package:equatable/equatable.dart';

abstract class RecoverImageHomeState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class RecoverImageHomeStateInitial extends RecoverImageHomeState {
  RecoverImageHomeStateInitial();
  RecoverImageHomeStateInitial copy(data, response) => RecoverImageHomeStateInitial();
  @override
  // TODO: implement props

  List<Object> get props => [];
}

class RecoverImageHomeStateFailure extends RecoverImageHomeState {
  RecoverImageHomeStateFailure();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class RecoverImageHomeStateStart extends RecoverImageHomeState {
  RecoverImageHomeStateStart();
  RecoverImageHomeStateStart copy() => RecoverImageHomeStateStart();
  @override
  // TODO: implement props
  List<Object> get props => [];
}
