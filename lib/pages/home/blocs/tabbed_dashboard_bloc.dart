

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_recovery/pages/home/events/tabbed_dashboard_event.dart';
import 'package:image_recovery/pages/home/states/app_tab.dart';

class TabbedDashboardBloc extends Bloc<TabbedDashboardEvent,AppTab>{
  TabbedDashboardBloc() : super(AppTab.dashboardMain);
  @override
  Stream<AppTab> mapEventToState(TabbedDashboardEvent event) async* {
      if(event is TabbedDashboardEventUpdated){
        yield event.tab;
      }
  }

}