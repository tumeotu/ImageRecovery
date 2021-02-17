
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_recovery/modules/tintuc/blocs/dashboard_tintuc_bloc.dart';
import 'package:image_recovery/pages/home/blocs/dashboard_main_bloc.dart';
import 'package:image_recovery/pages/home/blocs/tabbed_dashboard_bloc.dart';
import 'package:image_recovery/pages/home/events/dashboard_main_event.dart';
import 'package:image_recovery/routes.dart';
import 'package:image_recovery/utils/navigations/navigation_datasource.dart';

class NavigationResponse extends NavigationDataSource {
  @override
  Future<T> pushNavigation<T>(NamePage namePage, {params}) async {
    if (params == null) {
      params = new Map<String, dynamic>();
    }
    return await _callNavigation<T>(namePage, params: params);
  }

  _callNavigation<T>(NamePage namePage, {params}) async {
    return await Routes.sailor.navigate<T>(namePage.toString(), params: params);
  }

  @override
  Future popNavigation(BuildContext context, {params}) async {
    if (params == null) {
      await _callPopNavigation(context);
    } else {
      await _callPopNavigationParam(context, params);
    }
  }

  _callPopNavigation(BuildContext context) async {
    return Routes.sailor..pop();
  }

  _callPopNavigationParam(BuildContext context, params) async {
    return Routes.sailor..pop(params);
  }

  void _resetAndToMain(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => MultiBlocProvider(
                  providers: [
                    BlocProvider<TabbedDashboardBloc>(
                      create: (context) => TabbedDashboardBloc(),
                    ),
                    BlocProvider<DashboardBloc>(
                      create: (context) =>
                          DashboardBloc()..add(DashboardMainEventStart()),
                    ),
                    BlocProvider<DashboardTinTucBloc>(
                      create: (context) => DashboardTinTucBloc(),
                    ),
                    BlocProvider<DashboardTinTucBlocList>(
                      create: (context) => DashboardTinTucBlocList(),
                    ),
                  ],
                )),
        ModalRoute.withName("/"));
  }

  @override
  Future<T> pushMainAndRemoveAllNavigation<T>(BuildContext context) {
    _resetAndToMain(context);
  }
}
