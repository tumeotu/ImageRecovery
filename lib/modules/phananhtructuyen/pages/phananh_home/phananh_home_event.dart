import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_recovery/modules/phananhtructuyen/models/loaiphananh_danhmuc_model.dart';

abstract class PhanAnhHomeEvent extends Equatable {
  const PhanAnhHomeEvent();

  @override
  List<Object> get props => [];
}

class PhanAnhHomeEventLoadInProgress extends PhanAnhHomeEvent {}

class PhanAnhHomeEventShowModal extends PhanAnhHomeEvent {}

class PhanAnhHomeEventSelectItem extends PhanAnhHomeEvent {
  final LoaiPhanAnhDM item;
  final int index;
  final AnimationController animationController;
  const PhanAnhHomeEventSelectItem(
      {this.item, this.index, this.animationController});

  @override
  List<Object> get props => [item, index];
}
