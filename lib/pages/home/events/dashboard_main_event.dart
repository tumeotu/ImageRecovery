

import 'package:equatable/equatable.dart';

abstract class DashboardMainEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class DashboardMainEventStart extends DashboardMainEvent{}
class DashboardMainEventThongKeList extends DashboardMainEvent{
  final String loaiTK;

  DashboardMainEventThongKeList(this.loaiTK);
}