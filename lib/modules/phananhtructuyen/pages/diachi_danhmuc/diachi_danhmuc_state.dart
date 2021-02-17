import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_recovery/modules/phananhtructuyen/models/duong_danhmuc_model.dart';
import 'package:image_recovery/modules/phananhtructuyen/models/phuongxa_danhmuc_model.dart';
import 'package:image_recovery/modules/phananhtructuyen/pages/diachi_danhmuc/diachi_danhmuc.dart';

abstract class DiaChiDanhMucState extends Equatable {
  const DiaChiDanhMucState();

  @override
  List<Object> get props => [];
}

class DiaChiDanhMucStateInitiate extends DiaChiDanhMucState {}

///Loading PhuongXaDM
class DiaChiDanhMucStatePhuongXaDMLoading extends DiaChiDanhMucState {}

///Success load data PhuongXaDM
class DiaChiDanhMucStatePhuongXaDMSuccess extends DiaChiDanhMucState {
  final List<PhuongXaDanhMucModel> phuongXas;
  final int index;

  const DiaChiDanhMucStatePhuongXaDMSuccess({this.phuongXas, this.index});

  DiaChiDanhMucStatePhuongXaDMSuccess selectItem({phuongXas, index}) =>
      DiaChiDanhMucStatePhuongXaDMSuccess(
          phuongXas: phuongXas ?? this.phuongXas, index: index ?? this.index);

  @override
  List<Object> get props => [phuongXas];
}

///Failure load data PhuongXaDM
class DiaChiDanhMucStatePhuongXaDMFailure extends DiaChiDanhMucState {}

///Loading DuongDM
class DiaChiDanhMucStateDuongDMLoading extends DiaChiDanhMucState {
  final List<PhuongXaDanhMucModel> phuongXas;
  final int index;

  const DiaChiDanhMucStateDuongDMLoading({this.phuongXas, this.index});

  @override
  List<Object> get props => [phuongXas, index];
}

///Success load data DuongDM
class DiaChiDanhMucStateDuongDMSuccess extends DiaChiDanhMucState {
  final List<DuongDanhMucModel> duongs;
  final List<PhuongXaDanhMucModel> phuongXas;
  final int indexPhuongXa;
  final int indexDuong;

  const DiaChiDanhMucStateDuongDMSuccess(
      {@required this.duongs,
      @required this.phuongXas,
      this.indexPhuongXa,
      this.indexDuong});

  DiaChiDanhMucStateDuongDMSuccess cloneWith(
          {duongs, phuongXas, indexPhuongXa, indexDuong}) =>
      DiaChiDanhMucStateDuongDMSuccess(
        duongs: duongs ?? this.duongs,
        phuongXas: phuongXas ?? this.phuongXas,
        indexPhuongXa: indexPhuongXa ?? this.indexPhuongXa,
        indexDuong: indexDuong ?? this.indexDuong,
      );

  @override
  List<Object> get props => [duongs, phuongXas, indexPhuongXa, indexDuong];
}

///Failure load data DuongDM
class DiaChiDanhMucStateDuongDMFailure extends DiaChiDanhMucState {
  final List<PhuongXaDanhMucModel> phuongXas;
  final int index;

  const DiaChiDanhMucStateDuongDMFailure({this.phuongXas, this.index});

  @override
  List<Object> get props => [phuongXas, index];
}

//class DiaChiDanhMucStateSelectedDuong extends DiaChiDanhMucState {
//  final DuongDanhMucModel itemSelected;
//
//  const DiaChiDanhMucStateSelectedDuong(this.itemSelected);
//
//  @override
//  List<Object> get props => [itemSelected];
//}
