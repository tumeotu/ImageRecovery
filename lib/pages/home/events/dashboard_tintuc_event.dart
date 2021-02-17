import 'package:equatable/equatable.dart';
import 'package:image_recovery/data/models/dashboard_models.dart';

abstract class DashboardTinTucEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class DashboardTinTucEventPageChange extends DashboardTinTucEvent {
  final int index;

  DashboardTinTucEventPageChange(this.index);

  @override
  List<Object> get props => [];
}

class DashboardTinTucEventGetListData extends DashboardTinTucEvent {}
