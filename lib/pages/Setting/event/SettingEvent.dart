import 'dart:typed_data';
import 'package:equatable/equatable.dart';

abstract class SettingEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SettingEventStart extends SettingEvent{
  SettingEventStart();
}

