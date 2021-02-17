

import 'package:equatable/equatable.dart';
import 'package:image_recovery/modules/dichvucong/models/dichvucong_model.dart';

class DichVuCongState extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class DichVuCongStateInitial extends DichVuCongState{}
class DichVuCongStateFailure extends DichVuCongState{}
class DichVuCongStateSuccessfulThuTuc extends DichVuCongState{
  final List<DVC_ThuTuc> listData;
  final bool hasReachedEnd;

  DichVuCongStateSuccessfulThuTuc({this.listData, this.hasReachedEnd});
  @override
  List<Object> get props => [this.listData, this.hasReachedEnd];
  DichVuCongStateSuccessfulThuTuc cloneWith(
      {List<DVC_ThuTuc> listData, bool hasReachedEnd}) {
    return DichVuCongStateSuccessfulThuTuc(
        listData: listData ?? this.listData,
        hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd);
  }

}
// ignore: camel_case_types
class DichVuCongStateSuccessfulThuTuc_Detail extends DichVuCongState{
  final DVC_ThuTuc_Detail dataModel;
  DichVuCongStateSuccessfulThuTuc_Detail(this.dataModel);
  @override
  List<Object> get props => [this.dataModel,];

}

class DichVuCongStateSuccessfulLinhVuc extends DichVuCongState{
  final List<DVC_LinhVuc> listData;
  final int index;

  DichVuCongStateSuccessfulLinhVuc({this.listData,this.index});
  @override
  List<Object> get props => [this.listData];
}
class DichVuCongStateSuccessfulLinhVucItemSelected extends DichVuCongState{
  final DVC_LinhVuc itemSelected;
  final int index;

  DichVuCongStateSuccessfulLinhVucItemSelected(this.itemSelected,{this.index=0});
  @override
  List<Object> get props => [this.itemSelected];
}