

import 'package:equatable/equatable.dart';
import 'package:image_recovery/modules/phananhtructuyen/models/model.dart';

class LinhVucHoSoDanhMucState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LinhVucHoSoDanhMucStateInitiate extends LinhVucHoSoDanhMucState {}

///Loading 
class LinhVucHoSoDanhMucStateLoading extends LinhVucHoSoDanhMucState {}

///Success load data 
class LinhVucHoSoDanhMucStateSuccess extends LinhVucHoSoDanhMucState {
  final List<LinhVucHoSoModel> linhVucs;
  final int index;

  LinhVucHoSoDanhMucStateSuccess({this.linhVucs, this.index});

  LinhVucHoSoDanhMucStateSuccess selectItem({linhVucs, index}) =>
      LinhVucHoSoDanhMucStateSuccess(
          linhVucs: linhVucs ?? this.linhVucs, index: index ?? this.index);

  @override
  List<Object> get props => [this.linhVucs,this.index];
}

///Failure load data DuongDM
class LinhVucHoSoDanhMucStateFailure extends LinhVucHoSoDanhMucState {}