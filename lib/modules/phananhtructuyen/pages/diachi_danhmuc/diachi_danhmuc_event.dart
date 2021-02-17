import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_recovery/modules/phananhtructuyen/models/model.dart';

abstract class DiaChiDanhMucEvent extends Equatable {
  const DiaChiDanhMucEvent();

  @override
  List<Object> get props => [];
}

/// init data danh mục phường xã
class DiaChiDanhMucEventLoadInProgressPhuongXa extends DiaChiDanhMucEvent {}

///Selected phường xã
class DiaChiDanhMucEventLoadSelectedPhuongXa extends DiaChiDanhMucEvent {
  final List<PhuongXaDanhMucModel> phuongXas;
  final int index;

  const DiaChiDanhMucEventLoadSelectedPhuongXa(this.phuongXas,this.index);

  @override
  List<Object> get props => [phuongXas,index];
}

///Seleted đường
class DiaChiDanhMucEventLoadSelectedDuong extends DiaChiDanhMucEvent {
  final List<DuongDanhMucModel> duongs;
  final List<PhuongXaDanhMucModel> phuongXas;
  final int indexPhuongXa;
  final int indexDuong;

  const DiaChiDanhMucEventLoadSelectedDuong(
      {@required this.duongs, @required this.phuongXas,this.indexPhuongXa,this.indexDuong});


  @override
  List<Object> get props => [duongs, phuongXas,indexPhuongXa,indexDuong];
}
