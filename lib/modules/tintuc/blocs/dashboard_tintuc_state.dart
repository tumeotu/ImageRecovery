import 'package:equatable/equatable.dart';

import '../tintuc_imports.dart';

abstract class DashboardTinTucState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class DashboardTinTucStateInitial extends DashboardTinTucState {}

class DashboardTinTucStateFailure extends DashboardTinTucState {}

class DashboardTinTucStatePageChange extends DashboardTinTucState {
  final int index;
  final List<TinTucCongAn_Lst_Result> listData;

  DashboardTinTucStatePageChange({this.index, this.listData});

  @override
  // TODO: implement props
  List<Object> get props => [index, listData];
}

class DashboardTinTucStateSuccess extends DashboardTinTucState {
  final List<TinTucCongAn_Lst_Result> listData;
  final bool hasReachedEnd;

  DashboardTinTucStateSuccess({this.listData, this.hasReachedEnd});

  @override
  List<Object> get props => [this.listData, this.hasReachedEnd];

  DashboardTinTucStateSuccess cloneWith(
      {List<TinTucCongAn_Lst_Result> listData, bool hasReachedEnd}) {
    return DashboardTinTucStateSuccess(
        listData: listData ?? this.listData,
        hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd);
  }
}

class DashboardTinTucChiTietStateSuccess extends DashboardTinTucState {
  final TinTucCongAn_Lst_Result chitiet;
  final List<TinTucCongAn_Lst_Result> listData;

  DashboardTinTucChiTietStateSuccess(this.chitiet,this.listData);
  @override
  List<Object> get props => [this.chitiet,this.listData];
}
