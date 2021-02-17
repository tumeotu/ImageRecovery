import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_recovery/config_service.dart';
import 'package:image_recovery/data/apis/laysothutu/laystt_datasource.dart';
import 'package:image_recovery/pages/Filter/event/FilterEvent.dart';
import 'package:image_recovery/pages/Filter/state/FilterState.dart';


class FilterBloc extends Bloc<FilterEvent, FilterState> {
  LaySTTDataSource dataSource = getIt.get<LaySTTDataSource>();
  FilterBloc() : super(FilterMainStateInitial());

  @override
  Stream<FilterState> mapEventToState(FilterEvent event) async* {
    try {
      if (event is FilterEventStart) {
        yield FilterStartSuccess(event.image,event.filter);
      }
    } catch (exception) {
      yield FilterMainStateFailure();
    }
  }
}
