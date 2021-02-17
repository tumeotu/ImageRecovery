import 'package:equatable/equatable.dart';

abstract class RecoverImageHomeEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class RecoverImageHomeEventStart extends RecoverImageHomeEvent{
  RecoverImageHomeEventStart();
}