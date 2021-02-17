

import 'package:equatable/equatable.dart';
import 'package:image_recovery/pages/home/states/app_tab.dart';

abstract class TabbedDashboardEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}


class TabbedDashboardEventUpdated extends TabbedDashboardEvent {
  final AppTab tab;

  TabbedDashboardEventUpdated(this.tab);

  @override
  List<Object> get props => [tab];

  @override
  String toString() => 'TabUpdated { tab: $tab }';
}