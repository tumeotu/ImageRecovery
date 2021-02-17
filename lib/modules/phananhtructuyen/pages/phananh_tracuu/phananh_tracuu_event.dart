import 'package:equatable/equatable.dart';

abstract class PhanAnhTraCuuEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class PhanAnhTraCuuEventChitietState extends PhanAnhTraCuuEvent {
  final int id;

  PhanAnhTraCuuEventChitietState(this.id);

  @override
  List<Object> get props => [id];
}

class PhanAnhTraCuuEventResetIndex extends PhanAnhTraCuuEvent {}

class PhanAnhTraCuuEventGetListDataFilter extends PhanAnhTraCuuEvent {
  PhanAnhTraCuuEventGetListDataFilter({this.pageIndex,this.loaiPhanAnhID,this.isClear});

  final int pageIndex;
  final int loaiPhanAnhID;
  final bool isClear;

  @override
  List<Object> get props => [this.pageIndex,this.loaiPhanAnhID,this.isClear];
}

class PhanAnhTraCuuEventGetListData extends PhanAnhTraCuuEvent {}

class PhanAnhTraCuuEventSearchByLoaiPhanAnh extends PhanAnhTraCuuEvent {
  final int loaiPhanAnhID;

  PhanAnhTraCuuEventSearchByLoaiPhanAnh({this.loaiPhanAnhID});

  @override
  List<Object> get props => [loaiPhanAnhID];
}

class PhanAnhTraCuuEventFilterCommand extends PhanAnhTraCuuEvent {
  final int loaiPhanAnhID;

  PhanAnhTraCuuEventFilterCommand({this.loaiPhanAnhID});

  @override
  List<Object> get props => [loaiPhanAnhID];
}
