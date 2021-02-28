
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_recovery/data/models/user_models.dart';

class AccountEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AccountEventStart extends AccountEvent{
  bool Changing;
  Uint8List image;
  AccountEventStart(this.Changing, this.image);
  @override
  // TODO: implement props
  List<Object> get props => [this.Changing, this.image];
}

