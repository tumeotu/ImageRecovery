import 'package:equatable/equatable.dart';

abstract class DashboardTinTucEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class DashboardTinTucEventListSlider extends DashboardTinTucEvent {}
class DashboardTinTucEventResetState extends DashboardTinTucEvent {}
class DashboardTinTucEventChitietState extends DashboardTinTucEvent {
  final int tintuc_id;

  DashboardTinTucEventChitietState(this.tintuc_id);
}
class DashboardTinTucEventPageChange extends DashboardTinTucEvent {
  final int index;

  DashboardTinTucEventPageChange(this.index);

  @override
  List<Object> get props => [];
}

class DashboardTinTucEventGetListData extends DashboardTinTucEvent {
  final String keysearch;
  DashboardTinTucEventGetListData({this.keysearch});
  @override
  List<Object> get props => [keysearch];
}

